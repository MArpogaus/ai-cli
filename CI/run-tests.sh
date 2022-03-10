#!/bin/bash

set -ex

echo "Check if command exists"
type ai-cli

# both init and upgrade are needed to successfully use ai-cli run 

echo "exec init"
bash -x ai-cli init
echo "exec init finished successfully"

echo "exec upgrade"
bash -x ai-cli upgrade
echo "exec init finished successfully"

echo "exec run"
( cd tests/run_basic && bash -x ./exec_test.sh )
echo "exec run finished successfully"
