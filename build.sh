#!/bin/sh

set -eu

gitea_version='1.8.0'
gitea_checksum='799f5e05c9af07507e9ac2fb5b814b255bc633a7'
image_name='orzech/gitea'

docker build \
  --disable-content-trust=false \
  --build-arg GITEA_VERSION="$gitea_version" \
  --build-arg GITEA_CHECKSUM="$gitea_checksum" \
  -t "${IMAGE_NAME:-${image_name}}" \
  .
