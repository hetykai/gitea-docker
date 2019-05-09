FROM golang:alpine as builder
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/' /etc/apk/repositories && sed -i 's/http:/https:/' /etc/apk/repositories
RUN set -eu; apk --no-cache add \
             gcc \
             git \
             make \
             musl-dev

ENV GOPATH="/go"
ENV SRC_DIR="${GOPATH}/src/code.gitea.io/gitea"
WORKDIR "$SRC_DIR"

ARG GITEA_VERSION
ARG GITEA_REPO_URL="https://github.com/go-gitea/gitea.git"
RUN set -eu; git clone --branch "${GITEA_VERSION}" --depth 1 --no-checkout "$GITEA_REPO_URL" .; \
             git checkout "$GITEA_VERSION"

ARG GITEA_BUILD_TAGS="bindata sqlite sqlite_unlock_notify"
RUN set -eu; TAGS="$GITEA_BUILD_TAGS" make generate build

FROM hety/alpine
RUN set -eu; apk --no-cache add \
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
RUN set -eu; addgroup -S -g 1000 git; \
             adduser -S -D -G git -u 1000 -s '/bin/bash' -H -h '/data/git' git
RUN set -euo pipefail; echo "root:$(head -c 32 /dev/urandom | base64)" | chpasswd; \
                       echo "git:$(head -c 32 /dev/urandom | base64)" | chpasswd

COPY --from=builder "/go/src/code.gitea.io/gitea/gitea" "/usr/local/bin/gitea"
COPY files /

VOLUME ["/data"]

ENV GITEA_CUSTOM="/data/gitea"

ENTRYPOINT ["/usr/local/bin/entrypoint"]

EXPOSE 22 3000
