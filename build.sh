#!/bin/sh

set -eu

gitea_version='1.9.3'
gitea_checksum='2f715713052b6e3dc1f912b333816da414e99743'
image_name='orzech/gitea'
source='https://orzechowski.tech/git/orzech/gitea-docker'

if [ -n "${SOURCE_COMMIT:-}" ]; then
    source="${source}/src/commit/${SOURCE_COMMIT}"
fi

docker build \
  --disable-content-trust=false \
  --build-arg "gitea_version=${gitea_version}" \
  --build-arg "gitea_checksum=${gitea_checksum}" \
  --build-arg "source=${source}" \
  -t "${IMAGE_NAME:-${image_name}}" \
  .
