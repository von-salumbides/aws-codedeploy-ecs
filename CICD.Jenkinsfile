pipeline {
  agent any 
  options {
    ansiColor("xterm")
    withAWS(credentials: 'AWS_ACCESS_KEY_ID', region: 'us-east-2')
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
      println("deploying")
    }
  }
  post {
    always {
      cleanWs()
    }
  }
}