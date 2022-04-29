pipeline {
  agent any 
  options {
    ansiColor("xterm")
    withAWS(credentials: 'AWS_ACCESS_KEY_ID', region: 'us-east-2')
  }
  stages {
    stage("BUILD") {
      println("building artifact")
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