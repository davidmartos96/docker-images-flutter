#!/usr/bin/env bash

set -e

docker build --cache-from davidmartos96/flutter:${FLUTTER_VERSION/+/-} \
             --tag davidmartos96/flutter:${FLUTTER_VERSION/+/-} \
             --tag davidmartos96/flutter:$DOCKER_TAG \
             --build-arg flutter_version=$FLUTTER_VERSION \
             sdk
#docker build --cache-from davidmartos96/flutter:${FLUTTER_VERSION/+/-}-web \
#             --tag davidmartos96/flutter:${FLUTTER_VERSION/+/-}-web \
#             --tag davidmartos96/flutter:$DOCKER_TAG-web \
#             --build-arg flutter_tag=${FLUTTER_VERSION/+/-} \
#             web
