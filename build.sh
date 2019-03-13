#!/bin/sh

set -eu

gitea_version='1.7.4'
gitea_checksum='9f33aa61bd94563cb497ab111249b5a3345e05d7'
image_name='orzech/gitea'

docker build \
  --disable-content-trust=false \
  --build-arg GITEA_VERSION="$gitea_version" \
  --build-arg GITEA_CHECKSUM="$gitea_checksum" \
  -t "${IMAGE_NAME:-${image_name}}" \
  .
