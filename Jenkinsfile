pipeline {
  agent any 
  stages {
    stage('Check Environment') {
        steps {
          echo 'Check Prerequisites'
          sh 'docker -v'
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

  stage('Create Kubernetes Cluster') {
        steps {
          echo 'Creating Kubernetes Cluster'
          withAWS(region:'us-west-2',credentials:'awscreds') {
            sh "aws eks --region us-west-2 update-kubeconfig --name capstone-eks-cluster"
            echo 'Present Working Directory'
            sh "pwd"
            sh "kubectl apply -f /var/lib/jenkins/workspace/capstone_master/kubernetes/config/eks-auth-cm.yaml"
            sh "kubectl apply -f /var/lib/jenkins/workspace/capstone_master/kubernetes-confs/eks-deployment.yaml"
            sh "kubectl apply -f /var/lib/jenkins/workspace/capstone_master/kubernetes-confs/eks-service.yaml"
            sh "kubectl get nodes"
            sh "kubectl get pods"
            sh "kubectl get svc service-capstone -o yaml"
          }
        }
    }
  stage('Stop Container') {
        steps {
          sh 'docker stop capstone'
          sh 'docker rm capstone'
        }
    }
  }
}