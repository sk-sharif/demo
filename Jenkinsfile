pipeline {
  agent any
  stages {
     stage('Build Unit test') {
      steps{
        script {
          def isStartedByUser = currentBuild.rawBuild.getCause(hudson.model.Cause$UserIdCause) != null
          echo "${isStartedByUser}"
        }
      }
    }
  }
}
