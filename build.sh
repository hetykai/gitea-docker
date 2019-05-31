#!/bin/sh

set -eu

gitea_version='1.8.2'
gitea_checksum='dc73b2748dd15a21b4a21839470399c3bb8548c1'
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
