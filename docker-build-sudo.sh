#!/bin/bash

set -eo pipefail

IMAGE_TAG=v0.4.0

for IMAGE in tensorflow-1.12.0-notebook-cpu tensorflow-1.12.0-notebook-gpu; do
    (
        set -ex;
        docker build -t "dmrub/${IMAGE}-sudo:${IMAGE_TAG}" --build-arg "BASE_IMAGE=gcr.io/kubeflow-images-public/${IMAGE}:${IMAGE_TAG}" -f Dockerfile.sudo .;
        docker push "dmrub/${IMAGE}-sudo:${IMAGE_TAG}"
    )
done
