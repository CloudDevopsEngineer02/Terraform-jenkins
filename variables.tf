
variable "region" {
  default     = "us-east-1"
  description = "Choost the custom region from the aws region list"
  type        = "string"

}


variable "var2" {
  default     = "192.168.0.0/16"
  description = " Variables declarations "
}


variable "var3" {
  default     = "192.168.0.0/16"
  description = " Variables declarations "
}


variable "var1" {
  default     = "192.168.0.0/16"
  description = " Variables declarations "
}



variable "var24" {
  default = "172.168.10.0/24"
}

variable "igw_cidr" {
  default = "0.0.0.0/0"
}
variable "ec2_count" {
  default     = 2
  description = "Number of instances required for your project"
  type        = "string"
}

variable "ami" {
  type        = "map"
  default     = { us-east-1 = "ami-01d025118d8e760db" }
  description = "Amazon linux 2 ami used for  NAT instance "

}

variable "web_tags" {
  type = "map"
  default = {
    name        = "Webserver"
    Environment = "dev"
  }
}
variable "web_instancetype" {
  default = "t2.micro"
}

# insteead of runtime sending variables dyanmically if around 100's hecne "rfvars"  has been introduced.
