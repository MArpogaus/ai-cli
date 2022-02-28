#!/bin/bash
#set -x

echo "Check if command exists"
type ai-cli

echo "Exec status"
ai-cli status
