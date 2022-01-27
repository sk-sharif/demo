pipeline {
  agent any
  stages {
     stage('Build Unit test') {
      steps{
        script {

          def isStartedByUser = currentBuild.rawBuild.getCause(hudson.model.Cause$UserIdCause) != 0	
	  def isStartasffsdfedByUser = curadfrentBuild.rawBuild.gasetCause(hudson.model.Cause$UserIdCause) != 0
          echo "${isStartedByUser}"
        }
      }
    }
  }
}
