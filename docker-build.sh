#!/bin/bash

THIS_DIR=$( (cd "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P) )

set -eo pipefail

error() {
    echo >&2 "* Error: $*"
}

fatal() {
    error "$@"
    exit 1
}

message() {
    echo "$@"
}

APP_NAME=tensorflow-notebook
BASE_IMAGE_PREFIX=gcr.io/kubeflow-images-public/
BASE_IMAGE_NAME=tensorflow-1.12.0-notebook-gpu
BASE_IMAGE_TAG=v0.4.0
BASE_IMAGE=${BASE_IMAGE_PREFIX}${BASE_IMAGE_NAME}${BASE_IMAGE_TAG+:}${BASE_IMAGE_TAG}

#IMAGE_PREFIX=${IMAGE_PREFIX:-tensorflow-1.12.0-notebook-gpu}
IMAGE_TAG=${IMAGE_TAG:-${BASE_IMAGE_TAG}}
IMAGE_NAME=${IMAGE_NAME:-${BASE_IMAGE_NAME}}
IMAGE=${IMAGE_PREFIX}${IMAGE_NAME}${IMAGE_TAG+:}${IMAGE_TAG}

usage() {
    echo "./docker-build.sh [-t|--tag image] [--no-cache]"
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        -t|--tag)
            IMAGE="$2"
            shift 2
            ;;
        --tag=*)
            IMAGE="${1#*=}"
            shift
            ;;
        --no-cache)
            NO_CACHE=--no-cache
            shift
            ;;
        --help)
            usage
            exit
            ;;
        --)
            shift
            break
            ;;
        -*)
            fatal "Unknown option $1"
            ;;
        *)
            break
            ;;
    esac
done

echo "$APP_NAME Image Configuration:"
echo "IMAGE_NAME:        $IMAGE_NAME"
echo "NO_CACHE:          $NO_CACHE"

set -x
docker build \
    $NO_CACHE \
    --build-arg BASE_IMAGE="$BASE_IMAGE" \
    -t "${IMAGE}" \
    -f Dockerfile \
    "$THIS_DIR"
set +x
echo "Successfully built docker image $IMAGE"
