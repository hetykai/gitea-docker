#!/bin/sh

set -eu

gitea_version='1.4.1'
gitea_checksum='abc159637c2ec430d7636e35c6829f7fe0458864'
gitea_build_tags='bindata sqlite'
gitea_repo_url='https://github.com/go-gitea/gitea.git'
image_name='orzech/gitea'

docker build \
  --disable-content-trust=false \
  --build-arg GITEA_VERSION="$gitea_version" \
  --build-arg GITEA_CHECKSUM="$gitea_checksum" \
  --build-arg GITEA_BUILD_TAGS="$gitea_build_tags" \
  --build-arg GITEA_REPO_URL="$gitea_repo_url" \
  -t "${IMAGE_NAME:-${image_name}}" \
  .
