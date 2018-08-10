#!/bin/sh

set -eu

gitea_version='1.5.0'
gitea_checksum='cfe6941905de745aed1f9297d9717249f53e6e67'
image_name='orzech/gitea'

docker build \
  --disable-content-trust=false \
  --build-arg GITEA_VERSION="$gitea_version" \
  --build-arg GITEA_CHECKSUM="$gitea_checksum" \
  -t "${IMAGE_NAME:-${image_name}}" \
  .
