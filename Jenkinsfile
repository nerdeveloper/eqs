pipeline {
    agent any
    environment {
        SSH_KEY = credentials('cluster-ssh-key')
    }
    stages {
        stage('Create Cluster') {
            steps {
                sh "ansible-playbook playbook.yml -i inventory.ini -e ansible_ssh_private_key_file=$SSH_KEY 'ansible_python_interpreter=/usr/bin/python3"
            }
        }
    }
}
