pipeline {
  agent any 
  options {
    ansiColor("xterm")
    withAWS(credentials: 'AWS_ACCESS_KEY_ID', region: 'us-east-2')
  }
  environment {
    ANSIBLE_FORCE_COLOR = true
  }
  stages {
    stage("BUILD") {
      steps {
        withCredentials([gitUsernamePassword(credentialsId: 'von-salumbides',
          gitToolName: 'git-tool')]) {
          sh "make ${ANSIBLE_CMD}"
        }
        script {
          currentBuild.displayName = "${ANSIBLE_CMD}"
        }
      }
    }
    stage("DEPLOY") {
      steps {
        println("deploying")
      }
    }
  }
  post {
    always {
      cleanWs()
    }
  }
}