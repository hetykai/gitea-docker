#!/bin/sh

set -eu

gitea_version='1.8.3'
gitea_checksum='cf7a5b3d91320bfd49f07e42e8d274b838a3e76a'
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
