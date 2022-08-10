#!/bin/bash

set -ex

echo "CI: Check if command exists"
type ai-cli

# both init and upgrade are needed to successfully use ai-cli run 

echo "CI: exec init"
bash -x ai-cli init
echo "CI: exec init finished successfully"

echo "CI: start mlflow"
bash -ex ai-cli start-server
echo "CI: start mlflow finished successfully"

echo "CI: exec run"
bash -ex "cd examples/run_basic && bash -x ./ci-tests.sh "
echo "CI: exec run finished successfully"
