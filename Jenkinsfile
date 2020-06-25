#This is an declarative pipeline

pipeline {
  agent any {
    environment {
  PATH = ""${PATH}""
}
    stages {
        stage ('terraform-init-stage'){
            steps {
                sh "terraform init"

            }

        }
    }
  }
}
