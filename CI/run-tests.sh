#!/bin/bash

set -ex

echo "Check if command exists"
type ai-cli

# both init and upgrade are needed to successfully use ai-cli run 

echo "exec init"
bash -x ai-cli init
echo "exec init finished successfully"

echo "start mlflow"
bash -ex ai-cli start-server
echo "start mlflow finished successfully"

echo "exec run"
bash -ex ( cd examples/run_basic && bash -x ./ci-tests.sh )
echo "exec run finished successfully"
