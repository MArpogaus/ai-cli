#!/bin/bash
ai-cli start-server
#ai-cli -n basic run .
wget "http://localhost:5000"
cat index.html
cat /etc/ai-cli/config