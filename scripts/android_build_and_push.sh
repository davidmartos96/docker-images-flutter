#!/bin/bash

IMAGE_NAME="android-sdk"
REGISTRY="ghcr.io/davidmartos96"

ANDROID_IMAGE=$REGISTRY/$IMAGE_NAME:latest

PUSH="${1:-false}"

ANDROID_HASH=$(
    find sdk/Dockerfile.android -type f 2>/dev/null |
        sort |
        xargs sha256sum |
        sha256sum |
        awk '{print $1}'
)

FILE=".android-hash"

NEEDS_BUILD=false

if [[ ! -f "$FILE" ]]; then
    NEEDS_BUILD=true
elif [[ "$(cat $FILE)" != "$ANDROID_HASH" ]]; then
    NEEDS_BUILD=true
fi

echo "ANDROID HASH: $ANDROID_HASH .  Needs rebuild $NEEDS_BUILD"

if [[ "$NEEDS_BUILD" == "true" ]]; then
    echo "==> Android changed, rebuilding"

    docker buildx build --platform linux/amd64,linux/arm64 \
        -f sdk/Dockerfile.android -t "$ANDROID_IMAGE" .

    if [[ "$PUSH" == "true" ]]; then
        echo "==> Pushing Android image..."
        docker push "$ANDROID_IMAGE"
    else
        echo "==> Not pushing Android image"
    fi

    echo "$ANDROID_HASH" >"$FILE"
else
    echo "Android unchanged → skipping build"
fi
