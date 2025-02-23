#!/bin/bash
export NODE_RED_VERSION=$(grep -oE "\"node-red\": \"(\w*.\w*.\w*.\w*.\w*.)" package.json | cut -d\" -f4)

echo "#########################################################################"
echo "node-red version: ${NODE_RED_VERSION}"
echo "#########################################################################"

docker build --rm --no-cache \
    --build-arg http_proxy=${http_proxy} \
    --build-arg https_proxy=${https_proxy} \
    --build-arg ARCH=amd64 \
    --build-arg NODE_VERSION=14 \
    --build-arg NODE_RED_VERSION=${NODE_RED_VERSION} \
    --build-arg OS=buster-slim \
    --build-arg BUILD_DATE="$(date +"%Y-%m-%dT%H:%M:%SZ")" \
    --build-arg TAG_SUFFIX=default \
    --file Dockerfile.debian.python \
    --tag node-red-debian-python .
