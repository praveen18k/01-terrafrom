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

#This will attach to internet gateway
resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route"
  }
}
# Elastic IP for NAT
resource "aws_eip" "eip" {
  domain = "vpc"
}

#NAT Gateway to connect internet from private subnets
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public_subnet1

  tags = {
    Name = "gw NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}
##This will attach to NAT gateway
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
