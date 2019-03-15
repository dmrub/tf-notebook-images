ARG BASE_IMAGE=gcr.io/kubeflow-images-public/tensorflow-1.12.0-notebook-gpu:v0.4.0

FROM $BASE_IMAGE

RUN set -ex; \
    \
    apt-get update; \
    apt-get install -yq --no-install-recommends htop rsync

#ENTRYPOINT ["tini", "--"]
#CMD ["sh","-c", "jupyter notebook --notebook-dir=/home/jovyan --ip=0.0.0.0 --no-browser --allow-root --port=8888 --NotebookApp.token='' --NotebookApp.password='' --NotebookApp.allow_origin='*' --NotebookApp.base_url=${NB_PREFIX}"]
