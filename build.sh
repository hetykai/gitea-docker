#!/bin/sh

set -eu

gitea_version='1.7.2'
gitea_checksum='3b612ce42e48ec4fecd89eebcf9f73ac61927b25'
image_name='orzech/gitea'

docker build \
  --disable-content-trust=false \
  --build-arg GITEA_VERSION="$gitea_version" \
  --build-arg GITEA_CHECKSUM="$gitea_checksum" \
  -t "${IMAGE_NAME:-${image_name}}" \
  .
