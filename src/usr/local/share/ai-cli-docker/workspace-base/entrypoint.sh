#!/bin/bash -il

source ~/.bashrc
mamba activate ai-cli

echo "INFO AI-CLI-DOCKER: Executing $*"

exec $*
