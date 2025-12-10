stage('Deploy using Ansible (on master/controller)') {
    agent { label 'built-in' }
    steps {
        sh '''
            ansible-playbook /var/lib/jenkins/deploy.yml -i /etc/ansible/hosts
        '''
    }
}
