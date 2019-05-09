FROM golang:1.12-alpine3.9 as builder

RUN set -eu; \
    apk --no-cache add \
        gcc \
        git \
        make \
        musl-dev

ENV GOPATH="/go"
ENV SRC_DIR="${GOPATH}/src/code.gitea.io/gitea"
WORKDIR "$SRC_DIR"

ARG GITEA_VERSION
ARG GITEA_CHECKSUM
ARG GITEA_REPO_URL="https://github.com/go-gitea/gitea.git"
RUN set -eu; \
    git clone --branch "v${GITEA_VERSION}" --depth 1 --no-checkout "$GITEA_REPO_URL" .; \
    git checkout "$GITEA_CHECKSUM"

ARG GITEA_BUILD_TAGS="bindata sqlite"
RUN set -eu; \
    TAGS="$GITEA_BUILD_TAGS" make generate build

FROM alpine:3.9

LABEL maintainer="Piotr Orzechowski [orzechowski.tech]"

RUN set -eu; \
    apk --no-cache add \
        bash \
        ca-certificates \
        curl \
        git \
        linux-pam \
        openssh \
        s6 \
        sqlite \
        su-exec \
        tzdata
RUN set -eu; \
    addgroup -S -g 1000 git; \
    adduser -S -D -G git -u 1000 -s '/bin/bash' -H -h '/data/git' git
RUN set -euo pipefail; \
    echo "root:$(strings /dev/urandom | tr -d '[:cntrl:]' | head -c 128)" | chpasswd; \
    echo "git:$(strings /dev/urandom | tr -d '[:cntrl:]' | head -c 128)" | chpasswd

COPY --from=builder "/go/src/code.gitea.io/gitea/gitea" "/usr/local/bin/gitea"
COPY files /

VOLUME ["/data"]

ENV GITEA_CUSTOM="/data/gitea"

ENTRYPOINT ["/usr/local/bin/entrypoint"]

EXPOSE 22 3000
