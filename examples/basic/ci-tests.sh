#!/bin/bash
ai-cli start-server
#ai-cli -n basic run .

sleep 1m
wget http://server:5000 && cat index.html
