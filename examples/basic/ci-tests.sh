#!/bin/bash
ai-cli start-server
#ai-cli -n basic run .
wget http://0.0.0.0:5000 && cat index.html
cat /etc/ai-cli/config
docker network ls