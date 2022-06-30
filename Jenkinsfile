pipeline {
    agent any
    environment {
        AWS_ACCOUNT_ID="396682960377"
        AWS_DEFAULT_REGION="us-east-1" 
        IMAGE_REPO_NAME="jenkins-demo"
        IMAGE_TAG="latest"
        REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
    }
   
    stages {
        stage('Logging into AWS ECR') {
            steps {
                script {
                    sh "aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"
                }   
            }
        }

        stage('Building image') {
            steps{
                script {
                    sh "docker build -t ${IMAGE_REPO_NAME}"
                }
            }
        }

        stage('Pushing to ECR') {
            steps{  
                script {
                    sh "docker tag ${IMAGE_REPO_NAME}:${IMAGE_TAG} ${REPOSITORY_URI}:${IMAGE_TAG}"
                    sh "docker push ${REPOSITORY_URI}:${IMAGE_TAG}"
                }
            }
        }
    }
}