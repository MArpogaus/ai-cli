#!/bin/bash
#set -x

echo "Check if command exists"
type ai-cli

echo "exec init"
ai-cli init

echo "exec help"
ai-cli -h
