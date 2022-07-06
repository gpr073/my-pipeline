#!/usr/bin/env bash

export IMAGE=$1
sudo service docker start
docker-compose up -d
echo "success"