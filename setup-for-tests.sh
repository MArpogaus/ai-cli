#!/bin/bash

echo "setting up prerequisites for testing"

# check for gpu
lspci | grep -i nvidia

# start docker
service docker start

# setup git
git config --global user.name "git-dummy-name"
git config user.email "git-dummy@mail"
