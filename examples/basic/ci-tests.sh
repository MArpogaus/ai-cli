#!/bin/bash
ai-cli start-server
#ai-cli -n basic run .
wget "http://server:5000"
cat index.html
cat /etc/ai-cli/config