resource "aws_vpc" "main" {
  cidr_block           = var.vpc
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  tags = var.vpc_tags

}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = var.vpc_tags
}

resource "aws_subnet" "public_subnet1" {
  count             = length(var.public_subnet1)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet1[count.index]
  availability_zone = var.azs[count.index]

  tags = var.vpc_tags
}

resource "aws_subnet" "private_subnet1" {
  count             = length(var.private_subnet1)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet1[count.index]
  availability_zone = var.azs[count.index]

  tags = var.vpc_tags
}

resource "aws_route_table" "example" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route"
  }
}
