resource "aws_vpc" "main" {
  cidr_block = var.vpc

  tags = var.vpc_tags

}

