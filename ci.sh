#!/usr/bin/env bash

set -e

export FLUTTER_VERSION=3.41.9
export DOCKER_TAG=stable

: "${FLUTTER_VERSION:?FLUTTER_VERSION is required}"
: "${DOCKER_TAG:?DOCKER_TAG is required}"

if [ "$CIRRUS_BRANCH" != "master" ]
then
    docker build \
       --tag ghcr.io/davidmartos96/flutter:${FLUTTER_VERSION/+/-} \
       --tag ghcr.io/davidmartos96/flutter:$DOCKER_TAG \
       --build-arg flutter_version=$FLUTTER_VERSION \
       sdk
    exit 0
fi

echo "$GITHUB_TOKEN" | docker login ghcr.io -u davidmartos96 --password-stdin

docker build --platform linux/amd64,linux/arm64 --push \
   --tag ghcr.io/davidmartos96/flutter:${FLUTTER_VERSION/+/-} \
   --tag ghcr.io/davidmartos96/flutter:$DOCKER_TAG \
   --build-arg flutter_version=$FLUTTER_VERSION \
   sdk
