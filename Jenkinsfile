pipeline {
    agent any
    environment {
        VERSION = "${IMAGE_REPO_NAME}-v${env.BUILD_ID}"
        AWS_ACCOUNT_ID = "Enter AWS Account ID"
        AWS_DEFAULT_REGION = "us-east-1" 
        IMAGE_REPO_NAME = "jenkins-demo"
        //REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
        REPOSITORY_URI = "public.ecr.aws/f8w6t9j2"
    }
   
    stages { 
        stage('Logging into AWS ECR') {
            steps {
                script {
                    sh "aws ecr-public get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${REPOSITORY_URI}"
                }
            }
        }
        
        stage('Building image') {
            steps {
                script {
                    dockerImage = docker.build "${IMAGE_REPO_NAME}:${VERSION}"
                }
            }
        }
   
        stage('Pushing to ECR') {
            steps {  
                script {
                    sh "docker tag ${IMAGE_REPO_NAME}:${VERSION} ${REPOSITORY_URI}/${IMAGE_REPO_NAME}:${VERSION}"
                    sh "docker push ${REPOSITORY_URI}/${IMAGE_REPO_NAME}:${VERSION}"
                }
            }
        }
    }
}
