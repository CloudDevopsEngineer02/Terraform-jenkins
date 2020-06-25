


resource "aws_vpc" "north_virgin_vpc" {

  cidr_block       = "${var.var2}"
  instance_tenancy = "default"

  tags = {
    name        = "NV VPC"
    Environment = "${terraform.workspace}"
  }
}
