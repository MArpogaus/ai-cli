#!/bin/bash
ai-cli start-server
#ai-cli -n basic run .
wget http://app:5000 && cat index.html
