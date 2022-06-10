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
    CMIN \
    ARG_DRIVER_VERSION \
    ARG_DRIVER_PREFIX
    
# INSTALL CUDA
RUN apt-get update && \ 
    apt-get -y --no-install-recommends install gnupg software-properties-common && \
    apt-key del 7fa2af80 && \
    apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/3bf863cc.pub && \
    apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu2004/x86_64/7fa2af80.pub && \
    apt-get -y --no-install-recommends install linux-headers-$(uname -r) && \
    distribution=$(. /etc/os-release;echo $ID$VERSION_ID | sed -e 's/\.//g') && \
    wget https://developer.download.nvidia.com/compute/cuda/repos/$distribution/x86_64/cuda-$distribution.pin && \
    mv cuda-$distribution.pin /etc/apt/preferences.d/cuda-repository-pin-600 && \
    apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/$distribution/x86_64/7fa2af80.pub && \
    echo "deb http://developer.download.nvidia.com/compute/cuda/repos/$distribution/x86_64 /" | sudo tee /etc/apt/sources.list.d/cuda.list && \
    apt-get update

# FIX cuda-drivers metapackage version
RUN set -x && V=515.43.04-1 && \
    cd /tmp && \
    apt-get -y download cuda-drivers || apt-get -y download cuda-drivers && \
    dpkg-deb -x cuda-drivers* pkg-dir && \
    dpkg-deb --control cuda-drivers* pkg-dir/DEBIAN && \
    sed -ri "s/([0-9]+\.[0-9]+\.[0-9]+\-[0-9]+)/$V/g" pkg-dir/DEBIAN/control && \
    cat pkg-dir/DEBIAN/control && \
    dpkg -b pkg-dir fixed-cuda-drivers.deb && \
    #dpkg -i ./fixed-cuda-drivers.deb && \
    #apt-get -y --no-install-recommends install ./fixed-cuda-drivers.deb && \
    P=515 && \
    V=515.43.04* && \
    apt-get -y --allow-downgrades install nvidia-driver-$P=$V libnvidia-gl-$P=$V libnvidia-common-$P=$V nvidia-dkms-$P=$V nvidia-kernel-common-$P=$V nvidia-kernel-source-$P=$V libnvidia-compute-$P=$V libnvidia-extra-$P=$V nvidia-compute-utils-$P=$V libnvidia-decode-$P=$V libnvidia-encode-$P=$V nvidia-utils-$P=$V xserver-xorg-video-nvidia-$P=$V libnvidia-cfg1-$P=$V libnvidia-fbc1-$P=$V ./fixed-cuda-drivers.deb cuda-drivers-$P=$V cuda-$CMAJ-$CMIN libcudnn8=8*-1+cuda${CMAJ}.${CMIN}

#RUN apt-get - y -allow-downgrades install cuda-drivers-515:515.43*

#RUN apt-get -y install cuda-$CMAJ-$CMIN

ENV PATH=/usr/local/cuda-${CMAJ}.${CMIN}/bin${PATH:+:${PATH}}
ENV LD_LIBRARY_PATH=/usr/local/cuda-${CMAJ}.${CMIN}/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

#RUN fix-permissions "${CONDA_DIR}"

#RUN apt-get clean

# Switch user to avoid accidental container runs as root
USER $NB_USER

