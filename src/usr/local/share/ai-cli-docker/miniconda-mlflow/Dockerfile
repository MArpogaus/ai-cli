#!/bin/bash
#    AI-CLI Simplifying AI Experiments
#    Copyright (C) 2022  Marcel Arpogaus, Julian Jandeleit
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.
ARG CUDA_VERSION
FROM jupyter/base-notebook:latest
USER root

ENV DEBIAN_FRONTEND=noninteractive

ENV CONDA_DIR=/opt/conda \
    SHELL=/bin/bash
ENV PATH="${CONDA_DIR}/bin:${PATH}"


RUN set -x && \
    apt-get update -q && \
    apt-get install -q -y \
        bzip2 \
        ca-certificates \
        git \
        libglib2.0-0 \
        libsm6 \
        libxext6 \
        libxrender1 \
        mercurial \
        subversion \
        wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*    

RUN set -x && \
    mamba install --quiet --yes \
    'notebook' \
    'jupyterhub' \
    'jupyterlab' \ 
    'nb_conda_kernels' \ 
    'ipywidgets' \
    'mlflow' && \
    mamba clean --all -f -y && \
    npm cache clean --force && \
    jupyter lab clean

# Use Mamaba for mlflow envs
# export would not persist image generation: https://stackoverflow.com/questions/39597925/how-do-i-set-environment-variables-during-the-build-in-docker
ENV MLFLOW_CONDA_CREATE_ENV_CMD=mamba

# Use Mamaba for mlflow envs
# export would not persist image generation: https://stackoverflow.com/questions/39597925/how-do-i-set-environment-variables-during-the-build-in-docker
ADD entrypoint.sh /entrypoint.sh

WORKDIR /app

ENTRYPOINT ["/entrypoint.sh"]
