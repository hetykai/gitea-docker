#!/bin/sh

set -eu

gitea_version='1.6.2'
gitea_checksum='2631f7f64d24eef0ceb12eba6d384dfb6cb37527'
image_name='orzech/gitea'

docker build \
  --disable-content-trust=false \
  --build-arg GITEA_VERSION="$gitea_version" \
  --build-arg GITEA_CHECKSUM="$gitea_checksum" \
  -t "${IMAGE_NAME:-${image_name}}" \
  .
