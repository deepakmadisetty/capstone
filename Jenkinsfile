pipeline {
  agent any 
  stages {
    stage('Check Environment') {
        steps {
            sh 'echo "Hello World"'
            sh 'pwd'
            sh 'ls -lah'
        }
    }
    stage('Linting Files') {
        steps {
            sh 'tidy -q -e *.html'
            sh 'hadolint Dockerfile'
        }
    }

    stage('Build Docker Image') {
        steps {
            sh 'docker image build -t deepakmadisetty/capstone .'
            sh 'docker image ls'
            sh 'docker run --name deepakmadisetty/capstone -p 8080:80 -d deepakmadisetty/capstone'
        }
    }

    stage('Check Availabilty') {
        steps {
          sh 'curl -Is http://ec2-54-245-28-27.us-west-2.compute.amazonaws.com:8080 | head -1'
        }
    }
  }
}