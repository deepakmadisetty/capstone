pipeline {
  agent any 
  stages {
    stage('Check Environment') {
        steps {
          echo 'Check Prerequisites'
          sh 'docker -v'
          echo 'stopping containers from previous run'
          sh 'docker stop capstone'
          sh 'docker rm capstone'
        }
    }
    stage('Linting Files') {
        steps {
            sh 'tidy -q -e *.html'
            sh 'docker run --rm -i hadolint/hadolint < Dockerfile'
        }
    }

    stage('Build Docker Image') {
        steps {
            echo 'Building Docker Image'
            sh 'docker image build -t deepakmadisetty/capstone .'
            sh 'docker image ls'
            sh 'docker run --name capstone -p 8000:80 -d deepakmadisetty/capstone'
            echo 'Checking app status'
            sh 'curl -Is http://localhost:8000'
        }
    }

  stage('Deploying the app to Kubernetes Cluster') {
        steps {
          echo 'Creating Kubernetes Cluster'
          withAWS(region:'us-west-2',credentials:'awscreds') {
            dir('./') {
              sh '''aws eks --region us-west-2 update-kubeconfig --name capstone-eks-cluster'
              echo 'Kubernetes Deployment'
              kubectl apply -f kubernetes/config/eks-auth-cm.yml
              kubectl apply -f kubernetes/config/eks-deployment.yml
              kubectl apply -f kubernetes/config/eks-service.yml
              kubectl get nodes
              kubectl get pods
              kubectl get svc service-capstone -o yaml'''
            }
          }
        }
    }
  stage('Clean Up') {
        steps {
          sh 'docker system prune'
        }
    }
  }
}