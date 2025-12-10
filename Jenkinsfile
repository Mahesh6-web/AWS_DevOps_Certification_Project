pipeline {
  agent none

  environment {
    ANSIBLE_HOST_KEY_CHECKING = 'False'
  }

  stages {
    stage('Checkout + Build Docker (on slave)') {
      agent { label 'slave-node-1' }           // run on your slave (where Docker is installed)
      steps {
        // If you use HTTPS credentials in Jenkins, replace url with credentialsId in git step
        git branch: 'master',
            url: 'https://github.com/Mahesh6-web/AWS_DevOps_Certification_Project.git',
            credentialsId: 'github-https-credential'  // optional — use your HTTPS credential if required
        sh '''
          cd website
          docker build -t phpwebapp .
        '''
      }
    }

    stage('Push image (optional)') {
      agent { label 'slave-node-1' } // only if you push to registry from slave
      when { expression { false } }  // disable by default; enable if you want to push to Docker Hub/ACR
      steps {
        sh '''
          # docker login ...  (uncomment and fill if pushing)
          # docker tag phpwebapp yourrepo/phpwebapp:tag
          # docker push yourrepo/phpwebapp:tag
        '''
      }
    }

    stage('Deploy using Ansible (on master/controller)') {
      agent { label 'built-in' }  // run on controller (built-in), where ansible is installed
      steps {
        // Inventory/deploy.yml are on master per your previous steps (/home/ubuntu/deploy.yml)
        sh '''
          ansible-playbook /home/ubuntu/deploy.yml -i /etc/ansible/hosts
        '''
      }
    }
  } // stages

  post {
    always {
      echo "Pipeline finished. Check build logs & target server (testserver) for app status."
    }
  }
}
