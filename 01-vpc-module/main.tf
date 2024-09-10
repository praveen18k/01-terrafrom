resource "aws_vpc" "main" {
  cidr_block = var.vpc

  tags = var.vpc_tags

}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = var.vpc_tags
}

resource "aws_subnet" "public_subnet1" {
  count             = length(var.private_subnet1)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet1[count.index]
  availability_zone = var.azs[count.index]

  tags = var.vpc_tags
}

resource "aws_subnet" "private_subnet1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet1

  tags = var.vpc_tags
}

