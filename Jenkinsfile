pipeline {
    agent any

    environment {
        ANSIBLE_HOSTS = 'inventory'  // Path to the Ansible inventory file
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm  // Checkout the repository containing the Ansible playbook
            }
        }

        stage('Install Prerequisites') {
            steps {
                script {
                    // Install Ansible if not already installed
                    sh '''
                        if ! command -v ansible &> /dev/null; then
                            sudo apt-get update -y
                            sudo apt-get install -y ansible
                        fi
                    '''
                }
            }
        }

        stage('Run Ansible Playbook') {
            steps {
                sh 'ansible-playbook -i ${ANSIBLE_HOSTS} install_software.yml'
            }
        }

        stage('Verify Installation') {
            steps {
                sh '''
                    docker --version
                    systemctl status jenkins
                '''
            }
        }
    }

    post {
        success {
            echo "Installation completed successfully!"
        }
        failure {
            echo "Installation failed. Check the logs for details."
        }
    }
}
