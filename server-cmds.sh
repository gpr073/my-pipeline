#!/usr/bin/env bash

export IMAGE=$1
aws ecr get-login-password --region $2 | docker login --username AWS --password-stdin $3.dkr.ecr.$2.amazonaws.com
docker-compose -f docker-compose.yaml up -d
echo "success"