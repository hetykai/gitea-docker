#!/bin/sh

set -eu

gitea_version=$(docker run --rm busybox wget -q https://github.com/go-gitea/gitea/releases/latest --no-check-certificate -O - | grep -E \/tag\/ | awk -F "[><]" '{print $3}' | tail -n 1)
repoName='hety/gitea'

docker build \
  --build-arg GITEA_VERSION="$gitea_version" \
  -t "$repoName:latest" \
  -t "$repoName:$gitea_version" \
  .

docker push $repoName:$gitea_version
