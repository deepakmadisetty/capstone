pipeline {
  agent any 
  stages {
    stage('Check Environment') {
        steps {
          echo 'Check Prerequisites'
          sh 'docker -v'
        }
    }
    stage('Linting Files') {
        steps {
            sh 'tidy -q -e *.html'
            sh 'docker run --rm -i hadolint/hadolint Dockerfile'
        }
    }

    stage('Build Docker Image') {
        steps {
            echo 'Building Docker Image'
            sh 'docker image build -t deepakmadisetty/capstone .'
            sh 'docker image ls'
            sh 'docker run --name capstone -p 8000:80 -d deepakmadisetty/capstone'
        }
    }

    stage('Create Kubernetes Cluster') {
        steps {
          echo 'Create Kubernetes Cluster'
        }
    }
  }
}