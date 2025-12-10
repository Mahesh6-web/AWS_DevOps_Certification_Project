pipeline {
    agent any

    environment {
        ANSIBLE_HOST_KEY_CHECKING = 'False'
    }

    stages {

        stage('Build Docker Image') {
            steps {
                sh '''
                    cd website
                    docker build -t phpwebapp .
                '''
            }
        }

        stage('Deploy using Ansible') {
            steps {
                sh '''
                    ansible-playbook /home/ubuntu/deploy.yml
                '''
            }
        }
    }
}
