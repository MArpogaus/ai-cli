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
FROM ai-cli/workspace-base

# switch to root to fix permissions for local user
USER root

ARG CMAJ \
    CMIN
    
# INSTALL CUDA
RUN apt-get update && \ 
    apt-get -y install gnupg software-properties-common && \
    apt-key del 7fa2af80 && \
    apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/3bf863cc.pub && \
    apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu2004/x86_64/7fa2af80.pub && \
    apt-get -y install linux-headers-$(uname -r) && \
    distribution=$(. /etc/os-release;echo $ID$VERSION_ID | sed -e 's/\.//g') && \
    wget https://developer.download.nvidia.com/compute/cuda/repos/$distribution/x86_64/cuda-$distribution.pin && \
    mv cuda-$distribution.pin /etc/apt/preferences.d/cuda-repository-pin-600 && \
    apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/$distribution/x86_64/7fa2af80.pub && \
    echo "deb http://developer.download.nvidia.com/compute/cuda/repos/$distribution/x86_64 /" | sudo tee /etc/apt/sources.list.d/cuda.list && \
    apt-get update && \
    apt-get -y install cuda-drivers && \
    apt-get update && \
    apt-get -y install cuda-${CMAJ}-${CMIN} && \
    apt-get update && \
    apt-get install libcudnn8=8*-1+cuda${CMAJ}.${CMIN} && \
    apt-get install libcudnn8-dev=8*-1+cuda${CMAJ}.${CMIN}

ENV PATH=/usr/local/cuda-${CMAJ}.${CMIN}/bin${PATH:+:${PATH}}
ENV LD_LIBRARY_PATH=/usr/local/cuda-${CMAJ}.${CMIN}/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

RUN fix-permissions "${CONDA_DIR}"

# Switch user to avoid accidental container runs as root
USER $NB_USER

