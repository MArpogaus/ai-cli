FROM ai-cli/workspace-base
USER root

ARG CMAJ \
    CMIN

ENV NVARCH="x86_64" \
    NV_CUDA_CUDART_VERSION="${CMAJ}.${CMIN}*" \
    NV_CUDA_COMPAT_PACKAGE="cuda-compat-${CMAJ}-${CMIN}" \
    NV_NVTX_VERSION="${CMAJ}.${CMIN}*" \
    NV_LIBNPP_PACKAGE="libnpp-${CMAJ}-${CMIN}=${CMAJ}.${CMIN}*" \
    NV_LIBCUSPARSE_VERSION="${CMAJ}*" \
    NV_LIBCUBLAS_PACKAGE="libcublas-${CMAJ}-${CMIN}=${CMAJ}*" \
    NV_LIBNCCL_PACKAGE="libnccl2=2*+cuda${CMAJ}.${CMIN}" \
    NV_CUDNN_PACKAGE="libcudnn8=8*-1+cuda${CMAJ}.${CMIN}" \
    CUDA_VERSION="${CMAJ}.${CMIN}.0" \
    NV_CUDA_LIB_VERSION="${CMAJ}.${CMIN}.0-1"


# ---------- CUDA Installation --------------

#  add repo
RUN apt-get update && apt-get install -y --no-install-recommends \
    gnupg2 curl ca-certificates && \
    curl -fsSL https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/${NVARCH}/3bf863cc.pub | apt-key add - && \
    echo "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/${NVARCH} /" > /etc/apt/sources.list.d/cuda.list && \
    apt-get purge --autoremove -y curl \
    && rm -rf /var/lib/apt/lists/*
    
# install cuda from repo
RUN apt-get update && apt-get install -y --no-install-recommends \
       cuda-cudart-${CMAJ}-${CMIN}=${NV_CUDA_CUDART_VERSION} \
       ${NV_CUDA_COMPAT_PACKAGE} \
       ${NV_CUDNN_PACKAGE} \  
       cuda-libraries-${CMAJ}-${CMIN}=${NV_CUDA_LIB_VERSION} \
       ${NV_LIBNPP_PACKAGE} \
       cuda-nvtx-${CMAJ}-${CMIN}=${NV_NVTX_VERSION} \
       libcusparse-${CMAJ}-${CMIN}=${NV_LIBCUSPARSE_VERSION} \
       ${NV_LIBCUBLAS_PACKAGE} \
       ${NV_LIBNCCL_PACKAGE} \
    && ln -s cuda-${CMAJ}.${CMIN} /usr/local/cuda \
    && rm -rf /var/lib/apt/lists/*

# ------------------ CONFIGURE Container to recognize installation ------
# Required for nvidia-docker v1
RUN echo "/usr/local/nvidia/lib" >> /etc/ld.so.conf.d/nvidia.conf \
    && echo "/usr/local/nvidia/lib64" >> /etc/ld.so.conf.d/nvidia.conf
# nvidia-container-runtime
ENV PATH="/usr/local/nvidia/bin:/usr/local/cuda/bin:${PATH}" \
    LD_LIBRARY_PATH="/usr/local/nvidia/lib:/usr/local/nvidia/lib64" \
    NVIDIA_VISIBLE_DEVICES="all" \
    NVIDIA_DRIVER_CAPABILITIES="compute,utility"
# Keep apt from auto upgrading packages. See https://gitlab.com/nvidia/container-images/cuda/-/issues/88
RUN apt-mark hold "libcublas-${CMAJ}-${CMIN}" "libnccl2" "libcudnn8"

# ------------ JUPYTER NOTEBOOK Setup -------
# needs to be correct user
USER $NB_USER
