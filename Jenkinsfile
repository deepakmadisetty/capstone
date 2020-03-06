pipeline {
  agent any 
  stages {
    stage('Check Environment') {
        steps {
          echo 'Check Prerequisites'
          sh '''
            docker -v
            echo 'stopping containers from previous run'
            var1="capstone"
            var2=$(docker ps --format '{{.Names}}')
            if [ "$var1" == "$var2" ]
            then
                $(docker stop capstone && docker rm capstone > /dev/null 2>&1)
            else
                echo 'capstone is not running. exiting block....'
            fi
            '''
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