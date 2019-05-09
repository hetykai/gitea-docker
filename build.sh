#!/bin/sh

set -eu

gitea_version='1.8.1'
gitea_checksum='57b226e2849e6a910b84ccc7a00d234937231550'
image_name='orzech/gitea'

docker build \
  --disable-content-trust=false \
  --build-arg GITEA_VERSION="$gitea_version" \
  --build-arg GITEA_CHECKSUM="$gitea_checksum" \
  -t "${IMAGE_NAME:-${image_name}}" \
  .
