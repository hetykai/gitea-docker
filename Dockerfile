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

ARG gitea_version
ARG gitea_checksum
ARG gitea_repo_url="https://github.com/go-gitea/gitea.git"
RUN set -eu; \
    git clone --branch "v${gitea_version}" --depth 1 --no-checkout "$gitea_repo_url" .; \
    git checkout "$gitea_checksum"

ARG GITEA_BUILD_TAGS="bindata sqlite"
RUN set -eu; \
    TAGS="$GITEA_BUILD_TAGS" make generate build

FROM alpine:3.9

ARG source
LABEL maintainer='Piotr Orzechowski [orzechowski.tech]' source="$source"

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
