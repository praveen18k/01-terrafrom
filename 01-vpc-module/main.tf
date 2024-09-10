resource "aws_vpc" "main" {
  cidr_block = var.vpc

  tags = {
    Name = "my-vpc-module"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "my-vpc-module"
  }
}


resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = ["10.0.1.0/24", "10.0.2.0/24"]

  tags = {
    Name = "my-vpc-module"
  }
}

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = ["10.0.11.0/24", "10.0.22.0/24"]

  tags = {
    Name = "my-vpc-module"
  }
}

resource "aws_eip" "lb_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.lb_eip.id
  subnet_id     = aws_subnet.public.id

  tags = {
    Name = "gw NAT"
  }

  depends_on = [aws_internet_gateway.example]
}

