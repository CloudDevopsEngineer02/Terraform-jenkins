provider "aws" {
  version = "~> 2.0"
  region  = "${var.region}"
}


#The below backend s3 bucket will store terraform state file to mentioned s3 bucket
#Note it is highly recommended to "enable VERSIONING"
terraform {
  backend "s3" {
    bucket = "productionapp2020"
    key    = "terrform.tfstate"
    region = "ap-south-1"

    #The name of a DynamoDB table to use for state locking and consistency.
    #The table must have a primary key named LockID. If not present, locking will be disabled.
    #To LOCK your TF File should privilaged users only can access.
    #  dynamodb_table = "tf-bucket-state-lock"
  }
}

#VAriable declaration

#
# variable "var1" {
#   default     = "10.100.0.0/16"
#   type        = string
#   description = " Variables declarations "

# }

#Create a VPC The aws provided version not accepting the instances type
# resource "aws_vpc" "apac_mumbai_vpc" {
#   #count            = 0 #loops in terrafom how many time this code has to run.
#   #Conditions: as define below
#   #count = 1
#   count            = "${terraform.workspace == "Pre-Prod" ? 0 : 1}"
#   cidr_block       = "${var.var2}"
#   instance_tenancy = "default"
#
#   tags = {
#     Name        = "mumbai-comcast-vpc"
#     Environment = "${terraform.workspace}"
#   }
# }

#Workspaces are used to maintaine different environment (dev,QA,MA,Pre-Prod envs).
# # 1 output = 1 value multiple outputs we can not get from singlue output nest.
# output "aws_vpc" {
#   value = "${aws_vpc.apac_mumbai_vpc.cidr_block}"
# }
# output "aws_vpc_env" {
#
#   value = "${aws_vpc.apac_mumbai_vpc.tags.Environment}"
# }


#Data sources helps to retrive ifnormation from aws Cloud; eg what AMI etc details.
