#!/bin/sh

set -eu

gitea_version='1.5.1'
gitea_checksum='38d8b8cf49ce62dd7cfc806f1995d00e6fecc707'
image_name='orzech/gitea'

docker build \
  --disable-content-trust=false \
  --build-arg GITEA_VERSION="$gitea_version" \
  --build-arg GITEA_CHECKSUM="$gitea_checksum" \
  -t "${IMAGE_NAME:-${image_name}}" \
  .
