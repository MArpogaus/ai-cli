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
FROM jupyter/minimal-notebook:ubuntu-20.04

# switch to root to fix permissions for local user
USER root

ARG ARG_NB_USER \
    ARG_NB_UID \
    ARG_NB_GID \
    ARG_HOME \
    ARG_INSTALL_CUDA

ENV NB_USER=${ARG_NB_USER} \
    NB_UID=${ARG_NB_UID} \
    NB_GID=${ARG_NB_GID} \
    HOME=${ARG_HOME} \
    MLFLOW_CONDA_CREATE_ENV_CMD=mamba

RUN set -x && \
    mamba install --quiet --yes \
    'mlflow' \
    'nb_conda_kernels' && \
    mamba clean --all -f -y


RUN set -x && if [[ -z "$ARG_INSTALL_CUDA" ]] ; then echo "Not installing Cuda" ; else \
    echo "Argument is $ARG_INSTALL_CUDA, installing Cuda\n" && \
    apt-get update && apt-get -y install gnupg software-properties-common \
    ; fi

RUN apt-key del 7fa2af80
RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/3bf863cc.pub
RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu2004/x86_64/7fa2af80.pub

RUN apt-get -y install linux-headers-$(uname -r) && \
    distribution=$(. /etc/os-release;echo $ID$VERSION_ID | sed -e 's/\.//g') && \
    wget https://developer.download.nvidia.com/compute/cuda/repos/$distribution/x86_64/cuda-$distribution.pin && \
    mv cuda-$distribution.pin /etc/apt/preferences.d/cuda-repository-pin-600 && \
    apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/$distribution/x86_64/7fa2af80.pub && \
    echo "deb http://developer.download.nvidia.com/compute/cuda/repos/$distribution/x86_64 /" | sudo tee /etc/apt/sources.list.d/cuda.list && \
    apt-get update

RUN apt-get -y install cuda-drivers

#RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-keyring_1.0-1_all.deb && \
#    dpkg -i cuda-keyring_1.0-1_all.deb && \
RUN apt-get update && \
    apt-get -y install cuda-11-6


RUN apt-get update && \
    apt-get install libcudnn8=8.4.0.*-1+cuda11.6 && \
    apt-get install libcudnn8-dev=8.4.0.*-1+cuda11.6

RUN export PATH=/usr/local/cuda-11.7/bin${PATH:+:${PATH}} && \
    export LD_LIBRARY_PATH=/usr/local/cuda-11.7/lib64\
                         ${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

RUN fix-permissions "${CONDA_DIR}"

# Switch user to avoid accidental container runs as root
USER $NB_USER

