#!/bin/sh

set -eu

gitea_version='1.3.1'
gitea_checksum='81fd8c8fb686621acfdd91a73ade75b44030ce18'
gitea_build_tags='bindata sqlite'
gitea_repo_url='https://github.com/go-gitea/gitea.git'
image_name='orzech/gitea'

docker build \
  --disable-content-trust=false \
  --build-arg gitea_version="$gitea_version" \
  --build-arg gitea_checksum="$gitea_checksum" \
  --build-arg gitea_build_tags="$gitea_build_tags" \
  --build-arg gitea_repo_url="$gitea_repo_url" \
  -t "${IMAGE_NAME:-${image_name}}" \
  .
