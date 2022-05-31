#!/bin/bash

set -e

echo "setting up prerequisites for testing"

# start docker
sudo service docker start

# setup git
git config --global user.name "git-dummy-name"
git config user.email "git-dummy@mail"

# setup mlflow user
sudo mkdir -p /usr/share/ai-cli/htpasswd/
sudo htpasswd -Bb -c "/usr/share/ai-cli/htpasswd/dummy-mlflow.localhost" ${USER} 1234


echo "setup finished"
