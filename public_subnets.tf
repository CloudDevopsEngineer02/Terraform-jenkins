#Creating local variables to precise/compact the code
locals {

  az_names       = "${data.aws_availability_zones.nv_azs.names}"
  pub_subnet_ids = "${aws_subnet.public.*.id}"
}



resource "aws_subnet" "public" {
  count      = "${length(local.az_names)}"
  vpc_id     = "${aws_vpc.north_virgin_vpc.id}"
  cidr_block = "${cidrsubnet(var.var2, 8, count.index + 100)}" #https://www.terraform.io/docs/configuration/functions/cidrsubnet.html
  #availability_zone = "${data.aws_availability_zones.azs.number[0]}" : "This provides very first AZ value if you want list of all oneby one use index"
  availability_zone       = "${local.az_names[count.index]}"
  map_public_ip_on_launch = true #https://www.terraform.io/docs/providers/aws/r/subnet.html

  tags = {
    Name        = "Public Subnet - ${count.index + 1} "
    Environment = "${terraform.workspace}"
  }
}


#https://www.terraform.io/docs/providers/aws/r/internet_gateway.html
resource "aws_internet_gateway" "nv_igw" {

  vpc_id = "${aws_vpc.north_virgin_vpc.id}"
  tags = {
    name        = "Project 1 - north virginia Internet gateway"
    Environment = "${terraform.workspace}"
  }
}

#https://www.terraform.io/docs/providers/aws/r/route_table.html

resource "aws_route_table" "public_rtb" {

  vpc_id = "${aws_vpc.north_virgin_vpc.id}"

  route {
    cidr_block = "${var.igw_cidr}"
    gateway_id = "${aws_internet_gateway.nv_igw.id}"
  }
  # route {
  # #  ipv6_cidr_block        = "::/0"
  #   egress_only_gateway_id = "${aws_egress_only_internet_gateway.foo.id}"
  # }
  tags = {
    Name        = "Project1 - Public Route table"
    Environment = "${terraform.workspace}"

  }

}

#ref: https://www.terraform.io/docs/providers/aws/r/route_table_association.html

resource "aws_route_table_association" "public_rtb_assocaition" {
  count = "${length(local.az_names)}"
  #subnet_id      = "${local(count.index)}"
  subnet_id      = "${local.pub_subnet_ids[count.index]}" #count.index alwasy denotes with []
  route_table_id = "${aws_route_table.public_rtb.id}"
}
