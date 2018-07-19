#!/bin/sh

set -eu

gitea_version='1.4.3'
gitea_checksum='96c63a49376cd71c29a92e9a1685f07653376668'
image_name='orzech/gitea'

docker build \
  --disable-content-trust=false \
  --build-arg GITEA_VERSION="$gitea_version" \
  --build-arg GITEA_CHECKSUM="$gitea_checksum" \
  -t "${IMAGE_NAME:-${image_name}}" \
  .
