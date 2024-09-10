output "vpc_id" {
  value = aws_vpc.main.id
}

output "igw_id" {
  value = aws_internet_gateway.igw.id
}

output "public_subnet_ids" {
  value = aws_subnet.public_subnet1[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private_subnet1[*].id
}
