#!/bin/sh

set -eu

gitea_version='1.9.4'
gitea_checksum='6ab1d5a8a0ddef8a6e4c5561498ff136e5ebf30e'
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
