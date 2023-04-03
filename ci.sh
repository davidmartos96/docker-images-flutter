#!/usr/bin/env bash

set -e

if [ "$CIRRUS_BRANCH" != "master" ]
then
    docker buildx build --load \
       --tag ghcr.io/davidmartos96/flutter:${FLUTTER_VERSION/+/-} \
       --tag ghcr.io/davidmartos96/flutter:$DOCKER_TAG \
       --build-arg flutter_version=$FLUTTER_VERSION \
       sdk
    exit 0
fi

echo $GITHUB_TOKEN | docker login ghcr.io -u davidmartos96 --password-stdin

docker buildx build --push \
   --tag ghcr.io/davidmartos96/flutter:${FLUTTER_VERSION/+/-} \
   --tag ghcr.io/davidmartos96/flutter:$DOCKER_TAG \
   --build-arg flutter_version=$FLUTTER_VERSION \
   sdk
