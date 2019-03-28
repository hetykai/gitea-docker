#!/bin/sh

set -eu

gitea_version='1.7.5'
gitea_checksum='84a5b81d2745efba9cca23f8c2ca05441d8b436a'
image_name='orzech/gitea'

docker build \
  --disable-content-trust=false \
  --build-arg GITEA_VERSION="$gitea_version" \
  --build-arg GITEA_CHECKSUM="$gitea_checksum" \
  -t "${IMAGE_NAME:-${image_name}}" \
  .
