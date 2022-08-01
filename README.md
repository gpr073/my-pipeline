# my-pipeline

## Description

Used Jenkins to create a pipeline job which does the following:
- Jenkins checksout the github repo.
- AWS Credentials are provided through EC2 role to the Jenkins server to login to ECR.
- An image is built using Dockerfile in the repo.
- The image is versioned and pushed to the AWS ECR repo.
- In the last stage Jenkins uses SSH to connect to another EC2 server where the docker-compose.yaml and server-cmds.sh files are copied.
- The script server-cmds.sh is executed where it logs into the private ECR repo and executes the docker-compose.yaml file.
- Docker compose pulls the recently uploaded image and starts the container.

An Ansible playbook is used to configure a Jenkins master server on AWS where the above pipeline job is run.

## Getting Started

### Dependencies

* Ansible
* AWS account with needed permissions.

### Executing program

* Create an EC2 instance with a key pair.
* Create an EC2 role to give access to ECR and attach it to the EC2 server.
* Provide the key to Ansible playbook.
* Install Ansible and run the Ansible playbook.
* Login to the Jenkins master server and configure it.
* Provide the GitHub repo while creating the pipeline job.
* Create another EC2 instance with same key pair.
* Run the Jenkins pipeline job.
* The web application starts on port 3000.

On host server
```
ansible-playbook main.yaml
```
