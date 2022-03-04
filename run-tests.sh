#!/bin/bash

echo "Check if command exists"
type ai-cli

echo "exec init"
bash -x ai-cli init

echo "exec help"
bash -x ai-cli -h

echo "exec status"
bash -x ai-cli status

echo "exec run"
( cd tests/run_basic && bash -x ./exec_test.sh )
