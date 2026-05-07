#!/usr/bin/env bash

set -eo pipefail

# Config
IMAGE_NAME="flutter"
REGISTRY="ghcr.io/davidmartos96"

FLUTTER_IMAGE_1=$REGISTRY/$IMAGE_NAME:$DOCKER_TAG
FLUTTER_IMAGE_2=$REGISTRY/$IMAGE_NAME:${FLUTTER_VERSION/+/-}

PUSH="${1:-false}"

: "${FLUTTER_VERSION:?FLUTTER_VERSION is required}"
: "${DOCKER_TAG:?DOCKER_TAG is required}"

# Build android SDK image if needed
scripts/android_build_and_push.sh "$PUSH"

echo "==> Building Flutter image..."

docker buildx build --platform linux/amd64,linux/arm64 \
   -f sdk/Dockerfile.flutter \
   --tag "$FLUTTER_IMAGE_1" \
   --tag "$FLUTTER_IMAGE_2" \
   --build-arg flutter_version="$FLUTTER_VERSION" \
   .

if [[ "$PUSH" == "true" ]]; then
   echo "==> Pushing Flutter image..."

   # echo "$GITHUB_TOKEN" | docker login ghcr.io -u davidmartos96 --password-stdin

   docker push "$FLUTTER_IMAGE_1"
   docker push "$FLUTTER_IMAGE_2"
else
  echo "==> Push skipped"
fi

