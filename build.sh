#!/bin/sh

set -eu

gitea_version='1.7.6'
gitea_checksum='bafa9ff4323cef048412157e5f5a7bc516adf985'
image_name='orzech/gitea'

docker build \
  --disable-content-trust=false \
  --build-arg GITEA_VERSION="$gitea_version" \
  --build-arg GITEA_CHECKSUM="$gitea_checksum" \
  -t "${IMAGE_NAME:-${image_name}}" \
  .
