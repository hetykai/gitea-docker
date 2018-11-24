#!/bin/sh

set -eu

gitea_version=$(wget -q https://github.com/go-gitea/gitea/releases/latest -O - | grep -E \/tag\/ | awk -F "[><]" '{print $3}' | tail -n 1)
image_name='hety/gitea'

docker build \
  --build-arg GITEA_VERSION="$gitea_version" \
  -t "${IMAGE_NAME:-${image_name}}" \
  -t "$image_name:$gitea_version" \
  .
