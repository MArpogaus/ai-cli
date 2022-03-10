#!/bin/bash

set -e

echo "setting up prerequisites for testing"

# start docker
sudo service docker start

# setup git
git config --global user.name "git-dummy-name"
git config user.email "git-dummy@mail"

echo "setup finished"
