pipeline {
    agent any

    tools{
        maven 'maven'
    }

    stages{
        stage('Check and remove container'){
            steps{
                script{
                    def containerExists = sh(script: "docker ps -q -f name=das", returnStdout: true).trim()
                    if (containerExists) {
                    sh "docker stop das"
                    sh "docker rm das"
                    }
                }
            }
        }
        stage('Build package'){
            steps{
                sh 'mvn clean package'
            }
        }
        stage('Create image'){
            steps{
                sh 'sudo docker build -t app /var/lib/jenkins/workspace/webapp/'
            }
        }
        stage('Assign tag'){
            steps{
                sh 'docker tag app sivasundardas/siva'
            }
        }
        stage('Push to dockerhub'){
            steps{
                sh 'echo "Dascme@123" | docker login -u "sivasundardas" --password-stdin'
                sh 'docker push sivasundardas/siva'
            }
        }
        stage('Remove images'){
            steps{
                sh 'docker rmi -f $(docker images -q)'
            }
        }
        stage('Pull image from DockerHub'){
            steps{
                sh 'docker pull sivasundardas/siva'
            }
        }
        stage('Run a container'){
            steps{
                sh 'docker run -it -d --name das -p 8081:8080 sivasundardas/siva'
            }
        }
    }
    post {
        success {
            echo 'Deployment successful'
        }
        failure {
            sh 'docker rm -f das'
        }
        always{
            echo 'Deployed'
        }
    }

}