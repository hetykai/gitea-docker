#!/bin/sh

set -eu

gitea_version='1.6.0'
gitea_checksum='0da8bc9ec0e006a1a3209a46e255236590e4eb7e'
image_name='orzech/gitea'

docker build \
  --disable-content-trust=false \
  --build-arg GITEA_VERSION="$gitea_version" \
  --build-arg GITEA_CHECKSUM="$gitea_checksum" \
  -t "${IMAGE_NAME:-${image_name}}" \
  .
