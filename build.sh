#!/bin/sh

set -eu

gitea_version='1.7.1'
gitea_checksum='dfad569e40edf86346a10d11bc68c98c12bca30d'
image_name='orzech/gitea'

docker build \
  --disable-content-trust=false \
  --build-arg GITEA_VERSION="$gitea_version" \
  --build-arg GITEA_CHECKSUM="$gitea_checksum" \
  -t "${IMAGE_NAME:-${image_name}}" \
  .
