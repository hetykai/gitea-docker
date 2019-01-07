#!/bin/sh

set -eu

gitea_version='1.6.3'
gitea_checksum='30560b0f9b750cb96497ce110577c4293fc863ca'
image_name='orzech/gitea'

docker build \
  --disable-content-trust=false \
  --build-arg GITEA_VERSION="$gitea_version" \
  --build-arg GITEA_CHECKSUM="$gitea_checksum" \
  -t "${IMAGE_NAME:-${image_name}}" \
  .
