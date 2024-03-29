#!/bin/bash

set -ex

echo "CI: Check if command exists"
type ai-cli

# both init and upgrade are needed to successfully use ai-cli run 

#bash -x ai-cli ai-cli -c11.2 build all

echo "CI: exec init"
bash -x ai-cli init
echo "CI: exec init finished successfully"

echo "CI: start mlflow"
bash -ex ai-cli start-mlflow
echo "CI: start mlflow finished successfully"

echo "CI: exec run"
echo "CI: working directory is \"$PWD\""
cd examples/basic && bash -x ./ci-tests.sh
echo "CI: CI finished successfully"
