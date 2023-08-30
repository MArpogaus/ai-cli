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
ARG BASE_WORKSPACE_IMAGE_TAG
FROM jupyter/minimal-notebook:${BASE_WORKSPACE_IMAGE_TAG:-ubuntu-22.04}

ARG ARG_NB_USER \
    ARG_NB_UID \
    ARG_NB_GID \
    PYTHON_VERSION \
    MLFLOW_VERSION \
    ARG_HOME

ENV NB_USER=${ARG_NB_USER} \
    NB_UID=${ARG_NB_UID} \
    NB_GID=${ARG_NB_GID} \
    HOME=${ARG_HOME} \
    MLFLOW_CONDA_CREATE_ENV_CMD=mamba

RUN set -x && \
    rm ${CONDA_DIR}/conda-meta/pinned && \
    mamba install --quiet --yes \
    python==${PYTHON_VERSION}.* \
    mlflow==${MLFLOW_VERSION}.* \
    'nb_conda_kernels' && \
    mamba list python | grep '^python ' | tr -s ' ' | cut -d ' ' -f 1,2 >> "${CONDA_DIR}/conda-meta/pinned" && \
    mamba clean --all -f -y

# switch to root to fix permissions for local user and add entrypoint.sh
USER root
RUN chown -R $NB_UID:$NB_GID "${CONDA_DIR}"

COPY entrypoint.sh /entrypoint.sh 
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# Switch user to avoid accidental container runs as root
USER $NB_USER

