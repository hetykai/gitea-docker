#!/bin/sh

set -eu

gitea_version='1.7.0'
gitea_checksum='3fa49f3780ad3d79348f872f2523f57113d47ade'
image_name='orzech/gitea'

docker build \
  --disable-content-trust=false \
  --build-arg GITEA_VERSION="$gitea_version" \
  --build-arg GITEA_CHECKSUM="$gitea_checksum" \
  -t "${IMAGE_NAME:-${image_name}}" \
  .
