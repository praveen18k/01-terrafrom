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

#Route table resource
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "public-route"
  }
}
#Route for each public subnet CIDR block
resource "aws_route" "public_route" {
  for_each = var.public_subnet1 #iterate over each CIDR block

  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = each.value # use the current CIDR block from the list
  gateway_id             = aws_internet_gateway.igw.id
}
