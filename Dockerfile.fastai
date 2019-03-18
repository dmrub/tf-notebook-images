ARG BASE_IMAGE=gcr.io/kubeflow-images-public/tensorflow-1.12.0-notebook-gpu:v0.4.0

FROM $BASE_IMAGE

ARG PYTORCH_PACKAGE=https://download.pytorch.org/whl/cu100/torch-1.0.1.post2-cp36-cp36m-linux_x86_64.whl

RUN set -ex; \
    \
    apt-get update; \
    apt-get install -yq --no-install-recommends htop rsync; \
    pip3 install "$PYTORCH_PACKAGE" torchvision fastai jupyter scikit-learn

#ENTRYPOINT ["tini", "--"]
#CMD ["sh","-c", "jupyter notebook --notebook-dir=/home/jovyan --ip=0.0.0.0 --no-browser --allow-root --port=8888 --NotebookApp.token='' --NotebookApp.password='' --NotebookApp.allow_origin='*' --NotebookApp.base_url=${NB_PREFIX}"]
