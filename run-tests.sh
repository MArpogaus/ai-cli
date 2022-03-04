#!/bin/bash

echo "Check if command exists"
type ai-cli

# both init and upgrade are needed to successfully use ai-cli run 

echo "exec init"
bash -x ai-cli init

echo "exec upgrade"
bash -x ai-cli upgrade

echo "exec run"
( cd tests/run_basic && bash -x ./exec_test.sh )
