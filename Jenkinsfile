pipeline {
  agent none

  environment {
    ANSIBLE_HOST_KEY_CHECKING = 'False'
  }

  stages {

    /* ===========================================
       FIXED BUILD STAGE (runs on slave-node-1)
       =========================================== */
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
          ls -la website || true

          # Build Docker image using Dockerfile in repo root
          docker build -t phpwebapp -f Dockerfile .
        '''
      }
    }

    /* OPTIONAL – disabled push */
    stage('Push image (optional)') {
      agent { label 'slave-node-1' }
      when { expression { false } } // disabled unless you enable pushing to a registry
      steps {
        sh '''
          # docker login ...
          # docker tag phpwebapp yourrepo/phpwebapp:tag
          # docker push yourrepo/phpwebapp:tag
        '''
      }
    }

    /* ===========================================
       ANSIBLE DEPLOY STAGE (runs on master)
       =========================================== */
    stage('Deploy using Ansible (on master/controller)') {
      agent { label 'built-in' }
      steps {
        sh '''
          ansible-playbook /home/ubuntu/deploy.yml -i /etc/ansible/hosts
        '''
      }
    }
  }

  post {
    always {
      echo "Pipeline finished. Check build logs & target server (testserver) for app status."
    }
  }
}
