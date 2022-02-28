#!/bin/bash
#set -x

echo "Check if command exists"
type ai-cli

echo "Init"
echo $(ai-cli init)
