#!/bin/sh

set -eu

gitea_version='1.5.2'
gitea_checksum='31a738b221094cbfc32bf342fb3b76d4e78617da'
image_name='orzech/gitea'

docker build \
  --disable-content-trust=false \
  --build-arg GITEA_VERSION="$gitea_version" \
  --build-arg GITEA_CHECKSUM="$gitea_checksum" \
  -t "${IMAGE_NAME:-${image_name}}" \
  .
