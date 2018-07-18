#!/bin/sh

set -eu

gitea_version='1.4.1'
gitea_checksum='abc159637c2ec430d7636e35c6829f7fe0458864'
image_name='orzech/gitea'

docker build \
  --disable-content-trust=false \
  --build-arg GITEA_VERSION="$gitea_version" \
  --build-arg GITEA_CHECKSUM="$gitea_checksum" \
  -t "${IMAGE_NAME:-${image_name}}" \
  .
