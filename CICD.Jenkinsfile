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
    // stage("BUILD") {
    //   steps {
    //     withCredentials([gitUsernamePassword(credentialsId: 'von-salumbides',
    //       gitToolName: 'git-tool')]) {
    //       sh "make ${ANSIBLE_CMD}"
    //     }
    //     script {
    //       currentBuild.displayName = "${ANSIBLE_CMD}"
    //     }
    //   }
    // }
    stage("DEPLOY") {
      environment {
        CODEDEPLOY_APP_NAME   = "devops-poc"
        CODEDEPLOY_GROUP_NAME = "devops-api-poc"
        CODEDEPLOY_S3_BUCKET  = "devops-codedeploy-artifact"
        AWS_ACCOUNT_ID        = "${AWS_ACCOUNT_ID}"
        AWS_ACCOUNT_ROLE      = "${AWS_ACCOUNT_ROLE}"
      }
      steps {
        script {
          def DEPLOY_ID = createDeployment(
          s3Bucket: "${CODEDEPLOY_S3_BUCKET}",
          s3Key: "ansible/devops-api.yaml",
          s3BundleType: 'YAML', 
          applicationName: "${CODEDEPLOY_APP_NAME}",
          deploymentGroupName: "${CODEDEPLOY_GROUP_NAME}",
          deploymentConfigName: 'CodeDeployDefault.AllAtOnce',
          description: "Deployment Version ${VERSION_TAG}",
          waitForCompletion: 'true',
          ignoreApplicationStopFailures: 'false'
        )
        echo "${DEPLOY_ID}"
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