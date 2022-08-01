# my-pipeline

## Description

Used Jenkins to create a pipeline job which does the following:
- Jenkins checksout the github repo.
- AWS Credentials are provided through EC2 role to the Jenkins server to login to ECR.
- An image is built using Dockerfile in the repo.
- The image is versioned and pushed to the AWS ECR repo.
- In the last stage Jenkins uses SSH to connect to another EC2 server where the docker-compose.yaml and server-cmds.sh files are copied.
- The server-cmds.sh

## Getting Started

### Dependencies

* Docker

### Executing program

* Install Docker.
* The web application starts on port 3000.
```
docker compose up -d
```
