ARG TARGETARCH
FROM ai-cli/workspace-base as base
USER root

# --------------- ARCH SPECIFIC ENVS --------------

FROM base as base-amd64

ENV NVARCH x86_64

ENV NVIDIA_REQUIRE_CUDA "cuda>=11.5 brand=tesla,driver>=418,driver<419 brand=tesla,driver>=450,driver<451 brand=tesla,driver>=470,driver<471 brand=unknown,driver>=470,driver<471 brand=nvidia,driver>=470,driver<471 brand=nvidiartx,driver>=470,driver<471 brand=quadrortx,driver>=470,driver<471"
ENV NV_CUDA_CUDART_VERSION 11.5.50-1
ENV NV_CUDA_COMPAT_PACKAGE cuda-compat-11-5

ENV NV_NVTX_VERSION 11.5.50-1
ENV NV_LIBNPP_VERSION 11.5.1.53-1
ENV NV_LIBNPP_PACKAGE libnpp-11-5=${NV_LIBNPP_VERSION}
ENV NV_LIBCUSPARSE_VERSION 11.7.0.31-1

ENV NV_LIBCUBLAS_PACKAGE_NAME libcublas-11-5
ENV NV_LIBCUBLAS_VERSION 11.7.3.1-1
ENV NV_LIBCUBLAS_PACKAGE ${NV_LIBCUBLAS_PACKAGE_NAME}=${NV_LIBCUBLAS_VERSION}

ENV NV_LIBNCCL_PACKAGE_NAME libnccl2
ENV NV_LIBNCCL_PACKAGE_VERSION 2.11.4-1
ENV NCCL_VERSION 2.11.4-1
ENV NV_LIBNCCL_PACKAGE ${NV_LIBNCCL_PACKAGE_NAME}=${NV_LIBNCCL_PACKAGE_VERSION}+cuda11.5

ENV NV_CUDNN_VERSION 8.3.3.40
ENV NV_CUDNN_PACKAGE_NAME "libcudnn8"

ENV NV_CUDNN_PACKAGE "libcudnn8=$NV_CUDNN_VERSION-1+cuda11.5"

FROM base as base-arm64

ENV NVARCH sbsa
ENV NVIDIA_REQUIRE_CUDA "cuda>=11.5"
ENV NV_CUDA_CUDART_VERSION 11.5.50-1


ENV NV_NVTX_VERSION 11.5.50-1
ENV NV_LIBNPP_VERSION 11.5.1.53-1
ENV NV_LIBNPP_PACKAGE libnpp-11-5=${NV_LIBNPP_VERSION}
ENV NV_LIBCUSPARSE_VERSION 11.7.0.31-1

ENV NV_LIBCUBLAS_PACKAGE_NAME libcublas-11-5
ENV NV_LIBCUBLAS_VERSION 11.7.3.1-1
ENV NV_LIBCUBLAS_PACKAGE ${NV_LIBCUBLAS_PACKAGE_NAME}=${NV_LIBCUBLAS_VERSION}

ENV NV_LIBNCCL_PACKAGE_NAME libnccl2
ENV NV_LIBNCCL_PACKAGE_VERSION 2.11.4-1
ENV NCCL_VERSION 2.11.4-1
ENV NV_LIBNCCL_PACKAGE ${NV_LIBNCCL_PACKAGE_NAME}=${NV_LIBNCCL_PACKAGE_VERSION}+cuda11.5


ENV NV_CUDNN_VERSION 8.3.3.40
ENV NV_CUDNN_PACKAGE_NAME "libcudnn8"

ENV NV_CUDNN_PACKAGE "libcudnn8=$NV_CUDNN_VERSION-1+cuda11.5"

# -------------- CUDA BASE ----------------

FROM base-${TARGETARCH}

RUN apt-get update && apt-get install -y --no-install-recommends \
    gnupg2 curl ca-certificates && \
    curl -fsSL https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/${NVARCH}/3bf863cc.pub | apt-key add - && \
    echo "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/${NVARCH} /" > /etc/apt/sources.list.d/cuda.list && \
    apt-get purge --autoremove -y curl \
    && rm -rf /var/lib/apt/lists/*

ENV CUDA_VERSION 11.5.0

# For libraries in the cuda-compat-* package: https://docs.nvidia.com/cuda/eula/index.html#attachment-a
RUN apt-get update && apt-get install -y --no-install-recommends \
    cuda-cudart-11-5=${NV_CUDA_CUDART_VERSION} \
    ${NV_CUDA_COMPAT_PACKAGE} \
    && ln -s cuda-11.5 /usr/local/cuda && \
    rm -rf /var/lib/apt/lists/*

# Required for nvidia-docker v1
RUN echo "/usr/local/nvidia/lib" >> /etc/ld.so.conf.d/nvidia.conf \
    && echo "/usr/local/nvidia/lib64" >> /etc/ld.so.conf.d/nvidia.conf

ENV PATH /usr/local/nvidia/bin:/usr/local/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility

# ------------- CUDA RUNTIME -------------

ENV NV_CUDA_LIB_VERSION 11.5.0-1
RUN apt-get update && apt-get install -y --no-install-recommends \
    cuda-libraries-11-5=${NV_CUDA_LIB_VERSION} \
    ${NV_LIBNPP_PACKAGE} \
    cuda-nvtx-11-5=${NV_NVTX_VERSION} \
    libcusparse-11-5=${NV_LIBCUSPARSE_VERSION} \
    ${NV_LIBCUBLAS_PACKAGE} \
    ${NV_LIBNCCL_PACKAGE} \
    && rm -rf /var/lib/apt/lists/*

# Keep apt from auto upgrading the cublas and nccl packages. See https://gitlab.com/nvidia/container-images/cuda/-/issues/88
RUN apt-mark hold ${NV_LIBCUBLAS_PACKAGE_NAME} ${NV_LIBNCCL_PACKAGE_NAME}

# ------------- CUDA CUDNN --------------

RUN apt-get update && apt-get install -y --no-install-recommends \
    ${NV_CUDNN_PACKAGE} \
    && apt-mark hold ${NV_CUDNN_PACKAGE_NAME} \
    && rm -rf /var/lib/apt/lists/*

# ---------- ai-cli jupyter settings ---------

USER $NB_USER
