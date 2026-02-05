#!/bin/bash
set -ex

echo "CI: Check if command exists"
type ai-cli

# both init and upgrade are needed to successfully use ai-cli run

echo "CI: test 'init' command"
bash -ex ai-cli init

echo "CI: display help"
bash -ex ai-cli -h

echo "CI: test 'info' command"
bash -ex ai-cli info

echo "CI: test 'version' command"
bash -ex ai-cli version

echo "CI: test 'exec' command"
bash -ex ai-cli exec echo hello world

echo "CI: test 'start-mlflow' command"
bash -ex ai-cli start-mlflow

echo "CI: test 'status' command"
bash -ex ai-cli status

echo "CI: test 'restart-mlflow' command"
bash -ex ai-cli restart-mlflow

echo "CI: test 'stop-mlflow' command"
bash -ex ai-cli stop-mlflow

echo "CI: test 'run' command"
echo "CI: working directory is \"$PWD\""
cd examples/basic && bash -ex ./ci-tests.sh

echo "CI: all tests completed successfully"
