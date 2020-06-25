locals {

  env_tags = {
    Environment = "${terraform.workspace}"
  }
  web_tags = "${merge(local.env_tags)}" #merge is terraform built-in function, which merges 2 or maps.
}

resource "aws_instance" "web" {
  count         = "${var.ec2_count}"
  ami           = "${var.ami[var.region]}"
  instance_type = "${var.web_instancetype}"
  subnet_id     = "${local.pub_subnet_ids[count.index]}"
  tags          = "${local.web_tags}"
  user_data     = "${file("scripts/apache.sh")}"
}
