pipeline {
    agent any

    stages {
        stage('Install Prerequisites') {
            steps {
                script {
                    // Install Docker if not already installed
                    sh '''
                        if ! command -v docker &> /dev/null; then
                            sudo apt-get update -y
                            sudo apt-get install -y docker.io
                            sudo systemctl start docker
                            sudo systemctl enable docker
                        fi
                    '''

                    // Add Jenkins user to the Docker group
                    sh '''
                        if ! groups jenkins | grep -q '\bdocker\b'; then
                            sudo usermod -aG docker jenkins
                            sudo systemctl restart jenkins
                        fi
                    '''
                }
            }
        }

        stage('Verify Docker Installation') {
            steps {
                sh 'docker --version'
            }
        }

        stage('Run a Docker Container') {
            steps {
                sh 'docker run hello-world'
            }
        }
    }

    post {
        success {
            echo "Docker installation and verification completed successfully!"
        }
        failure {
            echo "Pipeline failed. Check the logs for details."
        }
    }
}
