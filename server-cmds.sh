#!/usr/bin/env bash

export IMAGE=$1
sudo service docker start
docker-compose -f docker-compose.yaml up -d
echo "success"