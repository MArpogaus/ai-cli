#!/bin/bash
#set -x

echo "Check if command exists"
type ai-cli

>&2 echo "This is in stderr"

echo "Exec status"
echo $(ai-cli status)
