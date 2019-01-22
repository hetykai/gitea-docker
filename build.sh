#!/bin/sh

set -eu

gitea_version='1.6.4'
gitea_checksum='eb0ee6bf584b530f5cfc23838112317560a5d925'
image_name='orzech/gitea'

docker build \
  --disable-content-trust=false \
  --build-arg GITEA_VERSION="$gitea_version" \
  --build-arg GITEA_CHECKSUM="$gitea_checksum" \
  -t "${IMAGE_NAME:-${image_name}}" \
  .
