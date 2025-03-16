pipeline {
    agent any

    stages {
        stage('Install Prerequisites with Ansible') {
            steps {
                script {
                    // Install Ansible if not already installed
                    sh '''
                        if ! command -v ansible &> /dev/null; then
                            sudo apt-get update -y
                            sudo apt-get install -y ansible
                        fi
                    '''

                    // Run the Ansible playbook to install Docker and Nginx
                    sh 'ansible-playbook -i inventory install_prerequisites.yml'
                }
            }
        }

        stage('Clone Git Repository') {
            steps {
                git url: 'https://github.com/cloudpost03/website_deploy.git', branch: 'main'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t my-web-app .'
            }
        }

        stage('Run Docker Container') {
            steps {
                sh 'docker run -d -p 8080:80 my-web-app'
            }
        }
    }

    post {
        success {
            echo "Pipeline completed successfully!"
        }
        failure {
            echo "Pipeline failed. Check the logs for details."
        }
    }
}
