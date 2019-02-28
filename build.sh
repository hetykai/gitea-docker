#!/bin/sh

set -eu

gitea_version='1.7.3'
gitea_checksum='8ab107c2dd09dd204983dd0f50df77e37141b98b'
image_name='orzech/gitea'

docker build \
  --disable-content-trust=false \
  --build-arg GITEA_VERSION="$gitea_version" \
  --build-arg GITEA_CHECKSUM="$gitea_checksum" \
  -t "${IMAGE_NAME:-${image_name}}" \
  .
