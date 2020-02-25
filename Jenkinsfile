pipeline {
  agent any 
  stages {
    stage('Build') {
        steps {
            sh 'echo "Hello World"'
            sh '''
            echo "Multiline shell steps works too"
            ls -lah'''
        }
    }
    stage('Lint HTML') {
        steps {
            sh 'tidy -q -e *.html'
        }
    }
    stage('Check Availabilty') {
        steps {
          sh 'curl -Is http://ec2-54-245-28-27.us-west-2.compute.amazonaws.com:8080 | head -1'
        }
    }
  }
}