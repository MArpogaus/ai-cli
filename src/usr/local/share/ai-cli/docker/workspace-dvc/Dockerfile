ARG BASE_IMAGE
FROM $BASE_IMAGE
user root
RUN echo 'APT::Get::Assume-Yes "true";' > /etc/apt/apt.conf.d/90assumeyes

# INSTALL CORE DEPENDENCIES
RUN apt-get update \
 && apt-get install --no-install-recommends \
    build-essential \
    apt-utils \
    apt-transport-https \
    ca-certificates \
    iputils-ping \
    software-properties-common \
    pkg-config \
    curl \
    wget \
    unzip \
    gpg-agent \
    sudo \
    tzdata \
    locales \
 && locale-gen en_US.UTF-8 \
 && apt-get clean \
 && rm --recursive --force /var/lib/apt/lists/*

# CONFIGURE LOCALE
ENV LANG="en_US.UTF-8"
ENV LANGUAGE="en_US:en"
ENV LC_ALL="en_US.UTF-8"

# INSTALL NODE, GIT & GO
RUN add-apt-repository ppa:git-core/ppa --yes \
 && add-apt-repository ppa:longsleep/golang-backports --yes \
 && curl --location https://deb.nodesource.com/setup_16.x | bash \
 && apt-get update \
 && apt-get install --yes git golang-go nodejs \
 && apt-get clean \
 && rm --recursive --force /var/lib/apt/lists/*

# INSTALL TERRAFORM
RUN curl --location https://apt.releases.hashicorp.com/gpg | sudo apt-key add - \
 && apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release --codename --short) main" \
 && apt update \
 && apt-get install --yes terraform \
 && apt-get clean \
 && rm --recursive --force /var/lib/apt/lists/*

# INSTALL LEO
RUN curl --location https://github.com/iterative/terraform-provider-iterative/releases/latest/download/leo_linux_amd64 \
 --output /usr/bin/leo \
 && chmod +x /usr/bin/leo

# INSTALL DVC
ARG DVC_VERSION=2
RUN cd /etc/apt/sources.list.d \
 && wget https://dvc.org/deb/dvc.list \
 && apt-get update \
 && apt-get install --yes "dvc=${DVC_VERSION}.*" \
 && apt-get clean \
 && rm --recursive --force /var/lib/apt/lists/*

# INSTALL CML
ARG CML_VERSION=0
RUN npm config set user 0 \
 && npm install --global "@dvcorg/cml@${CML_VERSION}"

# INSTALL VEGA
RUN add-apt-repository universe --yes \
 && apt-get update \
 && apt-get install --yes \
    libcairo2-dev \
    libpango1.0-dev \
    libjpeg-dev \
    libgif-dev \
    librsvg2-dev \
    libfontconfig-dev \
 && apt-get clean \
 && rm --recursive --force /var/lib/apt/lists/* \
 && npm config set user 0 \
 && npm install --global canvas@2 vega@5 vega-cli@5 vega-lite@5



# CONFIGURE RUNNER PATH
ENV CML_RUNNER_PATH=/home/runner
ENV MLRUNS_PATH=/mlruns
RUN mkdir ${CML_RUNNER_PATH} && chown jovyan "$CML_RUNNER_PATH" && chmod 777 "${CML_RUNNER_PATH}"
RUN mkdir "$MLRUNS_PATH" && chown jovyan "$MLRUNS_PATH" && chmod 777 "$MLRUNS_PATH"
#RUN chown jovyan "/home/$USER"
ENV HOME="$CML_RUNNER_PATH"
WORKDIR ${CML_RUNNER_PATH}

# SET SPECIFIC ENVIRONMENT VARIABLES
ENV IN_DOCKER=1
ENV RUNNER_ALLOW_RUNASROOT=1
# Environment variable used by cml to detect it's been installed using the docker image.
ENV _CML_CONTAINER_IMAGE=true
USER "$NB_USER"