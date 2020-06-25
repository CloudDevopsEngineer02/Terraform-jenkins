#This is an declarative pipeline

pipeline {
  agent any {
    environment {
      PATH = "${PATH}:${getTerraformPAth()}"
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
def  getTerraformPAth(){
	def tfHome = tool name: ‘terraform-01226’, type: ‘org.jenkinsci.plugins.terraform.TerraformInstallation’
return rfHome

}
