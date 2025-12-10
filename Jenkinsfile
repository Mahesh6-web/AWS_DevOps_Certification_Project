pipeline {
    agent none

    environment {
        ANSIBLE_HOST_KEY_CHECKING = 'False'
    }

    stages {

        stage('Checkout + Build Docker (on slave)') {
            agent { label 'slave-node-1' }

            steps {
                git branch: 'master',
                    url: 'https://github.com/Mahesh6-web/AWS_DevOps_Certification_Project.git',
                    credentialsId: 'github-https-credential'

                sh '''
                    echo "=== WORKSPACE CONTENTS ==="
                    pwd
                    ls -la
                    echo "=== website directory ==="
                    ls -la website

                    docker build -t phpwebapp -f Dockerfile .
                '''
            }
        }

        stage('Deploy using Ansible (on master/controller)') {
            agent { label 'built-in' }

            steps {
                sh '''
                    ansible-playbook /var/lib/jenkins/deploy.yml -i /etc/ansible/hosts
                '''
            }
        }
    }

    post {
        always {
            echo "Pipeline completed."
        }
    }
}
