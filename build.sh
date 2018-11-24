#!/bin/sh

set -eu

gitea_version=$(docker run --rm busybox wget -q https://github.com/go-gitea/gitea/releases/latest --no-check-certificate -O - | grep -E \/tag\/ | awk -F "[><]" '{print $3}' | tail -n 1)

docker build \
  --build-arg GITEA_VERSION="$gitea_version" \
  -t "$DOCKER_REPO:latest" \
  -t "$DOCKER_REPO:$gitea_version" \
  .

docker push $DOCKER_REPO:$gitea_version
docker push $DOCKER_REPO:latest
