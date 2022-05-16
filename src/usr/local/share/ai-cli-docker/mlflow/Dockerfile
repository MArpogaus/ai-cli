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
FROM python:3-alpine

ENV DEBIAN_FRONTEND=noninteractive \
    CONDA_DIR=/opt/conda \
    SHELL=/bin/bash \
    PATH="${CONDA_DIR}/bin:${PATH}"


#RUN apk add git
RUN apk update
RUN apk add make automake gcc g++ subversion python3-dev
RUN apk add --no-cache --update-cache gfortran build-base wget libpng-dev openblas-dev
RUN apk add py3-scipy
# Install python/pip
#ENV PYTHONUNBUFFERED=1
#RUN apk add --update --no-cache python3 && ln -sf python3 /usr/bin/python
#RUN python3 -m ensurepip
#RUN pip3 install --no-cache --upgrade pip setuptools

#RUN apt-get update -q && \
#    apt-get install -q -y \
#        git \
#        python \
#        pip && \
#    apt-get clean && \
#    rm -rf /var/lib/apt/lists/*

# forward python prints without buffering, setup mlflow
RUN set -x && pip install mlflow

ADD entrypoint.sh /entrypoint.sh

WORKDIR /app

ENTRYPOINT ["/entrypoint.sh"]

