pipeline {
  environment {
    registry = "akanshagiriya/dashboard"
    registryCredential = 'Docker_cred'
  }
  agent any
  stages {
    stage('Cloning Git') {
      steps {
          git branch: 'main', url: 'https://github.com/sk-sharif/dashboard.git'
      }
    }
     stage('Build Unit test') {
      steps{
        echo 'unit tests01'
      }
    }
  }
}
