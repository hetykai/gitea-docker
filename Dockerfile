ARG golang_version
ARG alpine_version
FROM "golang:${golang_version}-alpine${alpine_version}" as builder

RUN set -eu && apk --no-cache add \
               gcc \
               git \
               make \
               musl-dev

ENV GOPATH="/go"
ENV SRC_DIR="${GOPATH}/src/code.gitea.io/gitea"
WORKDIR "$SRC_DIR"

ARG gitea_repo_url
ARG gitea_version
RUN set -eu && git clone --branch "v${gitea_version}" --depth 1 "$gitea_repo_url" "$SRC_DIR"

ARG gitea_build_tags
RUN set -eu && TAGS="$gitea_build_tags" make generate build

ARG alpine_version
FROM "alpine:${alpine_version}"

LABEL maintainer="Piotr Orzechowski [orzechowski.tech]"

RUN set -eu && apk --no-cache add \
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
RUN set -eu && addgroup -S -g 1000 git \
            && adduser -S -D -G git -u 1000 -s '/bin/bash' -H -h '/data/git' git
RUN set -euo pipefail && echo "root:$(head -c 32 /dev/urandom | base64)" | chpasswd \
                      && echo "git:$(head -c 32 /dev/urandom | base64)" | chpasswd

COPY --from=builder "/go/src/code.gitea.io/gitea/gitea" "/usr/local/bin/gitea"
COPY files /

VOLUME ["/data"]

ENV GITEA_CUSTOM="/data/gitea"
ENV GODEBUG="netdns=go"

ENTRYPOINT ["/usr/local/bin/entrypoint"]

EXPOSE 22 3000
