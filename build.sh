#!/bin/sh

set -eu

gitea_version='1.4.0'
gitea_checksum='832e2ebe912b10a24fafe4b0d33b4f3e89f6375e'
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
