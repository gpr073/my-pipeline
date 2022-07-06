pipeline {
    agent any
    parameters {
        string(name: 'Version', defaultValue: '', description: '')
    }
    environment {
        VERSION = "version-${params.Version}"
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
        
        stage('Building image') {
            steps {
                script {
                    sh "docker build -t ${IMAGE_REPO_NAME}:${VERSION} ."
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

        stage('Provisioning a Server') {
            environment {
                AWS_ACCESS_KEY_ID = credentials('jenkins_aws_id')
                AWS_SECRET_ACCESS_KEY = credentials('jenkins_aws_key')
            }
            steps {
                script {
                    dir('terraform') {
                        sh "terraform init"
                        sh "terraform apply --auto-approve"
                        EC2_IP = sh(
                            script: "terraform output ec2-public-ip",
                            returnStdout: true
                        ).trim()
                    }
                }
            }
        }
        stage('SSH into EC2 server') {
            environment {
                IMAGE = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}:${VERSION}"
            }
            steps {
                script {
                    sleep(time: 30, unit: "SECONDS")
                    def shellCmd = "bash ./server-cmds.sh ${IMAGE}"
                    def ec2Instance = "ec2-user@${EC2_IP}"
                    def login = "aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"
                    sshagent(['ec2-server']) {
                        sh "scp -o StrictHostKeyChecking=no server-cmds.sh ${ec2Instance}:/home/ec2-user"
                        sh "scp -o StrictHostKeyChecking=no docker-compose.yaml ${ec2Instance}:/home/ec2-user"
                        sh "ssh -o StrictHostKeyChecking=no ${ec2Instance} ${login} ${shellCmd}"
                    }
                }
            }
        }
    }
}