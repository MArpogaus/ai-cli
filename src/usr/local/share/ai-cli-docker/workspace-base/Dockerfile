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

RUN fix-permissions "${CONDA_DIR}"

RUN mkdir /usr/local/bin/before-notebook.d/
RUN echo "mamba activate ai-cli" >> /usr/local/bin/before-notebook.d/conda.sh
RUN chmod +x /usr/local/bin/before-notebook.d/conda.sh

RUN printf "#!/bin/bash -il\nsource ~/.bashrc && source /usr/local/bin/before-notebook.d/conda.sh\nexec \$*\n" > /usr/local/bin/start.sh

# Switch user to avoid accidental container runs as root
USER $NB_USER

