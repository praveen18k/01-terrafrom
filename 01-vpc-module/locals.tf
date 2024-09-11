locals {
  azs = slice(data.aws_availability_zones.azs, 0, 2)
}
