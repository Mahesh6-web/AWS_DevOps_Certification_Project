pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'master',
                    url: 'git@github.com:Mahesh6-web/AWS_DevOps_Certification_Project.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh """
                    docker build -t phpwebapp .
                """
            }
        }

        stage('Deploy using Ansible') {
            steps {
                sh """
                    ansible-playbook /home/ubuntu/deploy.yml
                """
            }
        }
    }
}
