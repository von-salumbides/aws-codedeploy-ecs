pipeline {
  agent any
  options {
        ansiColor("xterm")
    }
  stages {
    stage ('Deploy') {
      steps {
        withCredentials([gitUsernamePassword(credentialsId: 'von-salumbides',
          gitToolName: 'git-tool')]) {
          sh "make ${TF_CMD}"
        }
        script {
          currentBuild.displayName = "${TF_CMD}"
        }
      }
    }
  } 
  post {
    always {
      cleanWs()
    }
  }
}