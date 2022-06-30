pipeline {
    agent any
    environment {
        IMAGE_REPO_NAME="jenkins-demo"
        IMAGE_TAG="latest"
        REPOSITORY_URI = "public.ecr.aws/f8w6t9j2"
    }
   
    stages {
        stage('Logging into AWS ECR') {
            steps {
                script {
                    sh "aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin ${REPOSITORY_URI}"
                }   
            }
        }

        stage('Building image') {
            steps{
                script {
                    sh "docker build -t ${IMAGE_REPO_NAME} ."
                }
            }
        }

        stage('Pushing to ECR') {
            steps{  
                script {
                    sh "docker tag ${IMAGE_REPO_NAME}:${IMAGE_TAG} ${REPOSITORY_URI}/${IMAGE_REPO_NAME}:${IMAGE_TAG}"
                    sh "docker push ${REPOSITORY_URI}/${IMAGE_REPO_NAME}:${IMAGE_TAG}"
                }
            }
        }
    }
}