#!/bin/sh

set -eu

gitea_version='1.5.3'
gitea_checksum='8733384e20b31f887cb8d8d4196cab939d49ab4b'
image_name='orzech/gitea'

docker build \
  --disable-content-trust=false \
  --build-arg GITEA_VERSION="$gitea_version" \
  --build-arg GITEA_CHECKSUM="$gitea_checksum" \
  -t "${IMAGE_NAME:-${image_name}}" \
  .
