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
FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

ENV CONDA_DIR=/opt/conda \
    SHELL=/bin/bash
ENV PATH="${CONDA_DIR}/bin:${PATH}"


RUN apt-get update -q && \
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

# Install miniforge
ENV MINIFORGE_VERSION=4.10.3-6
RUN set -x && \
    # Miniforge installer
    miniforge_arch=$(uname -m) && \
    miniforge_installer="Mambaforge-${MINIFORGE_VERSION}-Linux-${miniforge_arch}.sh" && \
    wget --quiet "https://github.com/conda-forge/miniforge/releases/download/${MINIFORGE_VERSION}/${miniforge_installer}" && \
        
    wget --quiet "https://github.com/conda-forge/miniforge/releases/download/${MINIFORGE_VERSION}/${miniforge_installer}.sha256" && \
    sha256sum --status -c "${miniforge_installer}.sha256" && \
    /bin/bash "${miniforge_installer}" -f -b -p "${CONDA_DIR}" && \
    rm "${miniforge_installer}" "${miniforge_installer}.sha256"  && \
    # Conda init script
    echo ". /opt/conda/etc/profile.d/conda.sh" >> /etc/bash.bashrc && \
    echo "conda activate base" >> /etc/bash.bashrc && \
    . /opt/conda/etc/profile.d/conda.sh && \
    # Conda configuration see https://conda.io/projects/conda/en/latest/configuration.html
    conda config --system --set auto_update_conda false && \
    conda config --system --set show_channel_urls true && \
    conda update --all --quiet --yes && \
    conda clean --all -f -y
    

RUN mamba install --quiet --yes \
    'notebook' \
    'jupyterhub' \
    'jupyterlab' \ 
    'nb_conda_kernels' \ 
    'ipywidgets' \
    'mlflow' && \
    mamba clean --all -f -y && \
    npm cache clean --force && \
    jupyter notebook --generate-config && \
    jupyter lab clean

# Use Mamaba for mlflow envs
# export would not persist image generation: https://stackoverflow.com/questions/39597925/how-do-i-set-environment-variables-during-the-build-in-docker
ENV MLFLOW_CONDA_CREATE_ENV_CMD=mamba

# Use Mamaba for mlflow envs
# export would not persist image generation: https://stackoverflow.com/questions/39597925/how-do-i-set-environment-variables-during-the-build-in-docker
ADD entrypoint.sh /entrypoint.sh

WORKDIR /app

ENTRYPOINT ["/entrypoint.sh"]
