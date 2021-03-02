pipeline {
    environment {
        SSH_KEY = credentials('cluster-ssh-key')
    }
    stages {
        stage('Create Cluster') {
            steps {
                echo $SSH_KEY > devops-test-2021.pem
                sh("ansible-playbook playbook.yml -i inventory.ini")
            }
        }
    }
}
