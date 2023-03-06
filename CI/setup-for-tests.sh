#!/bin/bash

set -e

echo "setting up prerequisites for testing"

# start docker
sudo service docker start

# setup network proxy
docker network create proxy_net

# setup git
git config --global user.name "git-dummy-name"
git config user.email "git-dummy@mail"

# setup mlflow
echo "setting up mlflow environment"
source /etc/ai-cli/config
sudo mkdir -p $MLFLOW_DATA
sudo mkdir -p /mlruns
sudo chmod 777 /mlruns
sudo chmod 777 $MLFLOW_DATA
sudo htpasswd -Bb -c "$HTPASSWD_PATH/${USER}-mlflow.localhost" ${USER} 1234


# install ts for timed outputs
sudo apt-get install moreutils

echo "setup finished"
