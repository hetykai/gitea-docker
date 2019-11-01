#!/bin/sh

set -eu

gitea_version='1.9.5'
gitea_checksum='83d04df3652bcc2b233f3d18d82ff21bd7204a89'
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
