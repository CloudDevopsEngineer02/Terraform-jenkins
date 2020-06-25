#https://www.terraform.io/docs/configuration/functions/slice.html

locals {
  prv_subnet_ids = "${aws_subnet.private.*.id}"
}


resource "aws_subnet" "private" {
  count      = "${length(slice(local.az_names, 0, 3))}"
  vpc_id     = "${aws_vpc.north_virgin_vpc.id}"
  cidr_block = "${cidrsubnet(var.var2, 8, count.index + length(local.az_names))}" #https://www.terraform.io/docs/configuration/functions/cidrsubnet.html
  #availability_zone = "${data.aws_availability_zones.azs.number[0]}" : "This provides very first AZ value if you want list of all oneby one use index"
  availability_zone = "${local.az_names[count.index]}"

  tags = {
    Name        = "Private Subnet - ${count.index + 1} "
    Environment = "${terraform.workspace}"
  }
}



resource "aws_instance" "nat" {
  ami                    = "${var.ami[var.region]}"
  instance_type          = "t2.micro"
  subnet_id              = "${local.prv_subnet_ids[0]}"
  source_dest_check      = false
  vpc_security_group_ids = ["${aws_security_group.nat_sg.id}"]
  tags = {
    Name        = "NAT instance"
    environment = "${terraform.workspace}"
  }
}


resource "aws_route_table" "private_rtb" {
  vpc_id = "${aws_vpc.north_virgin_vpc.id}"
  route {
    #vpc_id      = "${aws_vpc.north_virgin_vpc.id}"
    cidr_block  = "${var.igw_cidr}"
    instance_id = "${aws_instance.nat.id}"
  }
  tags = {
    name        = "private route table"
    environment = "${terraform.workspace}"
  }
}

resource "aws_security_group" "nat_sg" {
  name        = "nat-sg"
  description = "Allow traffic to private subnet group"
  vpc_id      = "${aws_vpc.north_virgin_vpc.id}"


  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    #  cidr_blocks = ["0.0.0.0/0"] no need for this usecase
  }

  tags = {
    Name        = "NAT_security group"
    environment = "${terraform.workspace}"
  }
}


resource "aws_route_table_association" "private_rtb_ass" {
  count = "${length(slice(local.az_names, 0, 3))}"
  #subnet_id      = "${local(count.index)}"
  subnet_id      = "${local.prv_subnet_ids[count.index]}" #count.index alwasy denotes with []
  route_table_id = "${aws_route_table.private_rtb.id}"
}


#
# resource "aws_nat_gateway" "nv_nat_gw" {
#
#   allocation_id = "${aws_eip.my_eip.nat.id}"
#   subnet_id     = "${local.prv_subnet_ids}"
#   #depends_on    = "${aws_internet_gateway.nv_igw.gw}"
#   tags = {
#     name        = "NAT GW North virginia"
#     Environment = "${terraform.workspace}"
#   }
#
# }
#
# resource "aws_route_table" "private_rtb" {
#
#   route {
#     cidr_block = "${var.igw_cidr}"
#     gateway_id = "${aws_nat_gateway.nv_nat_gw.id}"
#   }
#   tags = {
#
#     name        = "private route table"
#     environment = "${terraform.workspaace}"
#   }
#
# }
#
# resource "aws_route_table_association" "private_rtb_ass" {
#   count = "${length(local.az_names)}"
#   #subnet_id      = "${local(count.index)}"
#   subnet_id      = "${local.pub_subnet_ids[count.index]}" #count.index alwasy denotes with []
#   route_table_id = "${aws_route_table.private_rtb.id}"
# }
