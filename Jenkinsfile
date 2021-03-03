pipeline {
    agent any
    environment {
        SSH_KEY = credentials('cluster-ssh-key')
         DOCKER_USERNAME = credentials('docker_username')
         DOCKER_PASS = credentials('docker_pass')
         IMAGE_NAME = 'jenkins'
    }
    stages {
        stage('Create Cluster') {
            steps {
                sh "ansible-playbook playbook.yml -i inventory.ini -e ansible_ssh_private_key_file=$SSH_KEY -e ansible_python_interpreter=/usr/bin/python3"
            }
        }
        stage('Push Baked Jenkins Image to Docker Hub') {
                    steps {
                         sh "docker build --pull --rm -f "Dockerfile" -t nerdeveloper/$IMAGE_NAME:$BUILD_NUMBER ."
                         sh "docker login -u $DOCKER_USERNAME -p $DOCKER_PASS"
                         sh "docker push nerdeveloper/$IMAGE_NAME:$BUILD_NUMBER"
                    }
                }
    }
}
