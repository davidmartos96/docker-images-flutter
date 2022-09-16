#!/usr/bin/env bash

set -e

docker history davidmartos96/flutter:${FLUTTER_VERSION/+/-}
docker history davidmartos96/flutter:$DOCKER_TAG

if [ "$CIRRUS_BRANCH" != "master" ]
then
    exit 0
fi

docker login --username $DOCKER_USER_NAME --password $DOCKER_PASSWORD

docker push davidmartos96/flutter:${FLUTTER_VERSION/+/-}
docker push davidmartos96/flutter:$DOCKER_TAG
#docker push davidmartos96/flutter:${FLUTTER_VERSION/+/-}-web
#docker push davidmartos96/flutter:$DOCKER_TAG-web
