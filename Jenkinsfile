pipeline {
    agent any
    environment {
        SSH_KEY = credentials('ssh-key')
    }
    stages {
        stage('Create Cluster') {
            steps {
                sh "echo ${SSH_KEY} > devops-test-2021.pem && chmod 600 devops-test-2021.pem"
                sh "ansible-playbook playbook.yml -i inventory.ini"
            }
        }
    }
}
