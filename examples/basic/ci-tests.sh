#!/bin/bash
ai-cli init
ai-cli build all
ai-cli start mlflow
#ai-cli -n basic run .

sleep 1m
wget http://server:5000 && cat index.html
