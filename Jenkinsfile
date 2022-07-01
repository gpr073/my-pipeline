pipeline {
    agent any
    environment {
        VERSION = "version-${env.BUILD_ID}"
        AWS_ACCOUNT_ID = "396682960377"
        AWS_DEFAULT_REGION = "us-east-1" 
        IMAGE_REPO_NAME = "jenkins-demo"
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
        stage('Hello') {
            steps {
                script {
                    sh "echo Success"
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
                    sh "docker tag ${IMAGE_REPO_NAME}:${VERSION} ${REPOSITORY_URI}:${VERSION}"
                    sh "docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}:${VERSION}"
                }
            }
        }
    }
}
