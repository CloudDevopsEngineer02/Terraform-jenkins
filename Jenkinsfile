#This is an declarative pipeline

pipeline {
  agent any {
    stages {
        stage ('terraform-init-stage'){
            steps {
                sh "terraform init"

            }

        }
    }
  }
}
