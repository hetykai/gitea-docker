#!/bin/sh

set -eu

gitea_version='1.2.2'
gitea_build_tags='bindata sqlite'
gitea_repo_url='https://github.com/go-gitea/gitea.git'
golang_version='1.9'
alpine_version='3.6'
image_name='orzech/gitea'

docker build \
  --build-arg gitea_version="$gitea_version" \
  --build-arg gitea_build_tags="$gitea_build_tags" \
  --build-arg gitea_repo_url="$gitea_repo_url" \
  --build-arg golang_version="$golang_version" \
  --build-arg alpine_version="$alpine_version" \
  -t "${IMAGE_NAME:-${image_name}}" \
  .
