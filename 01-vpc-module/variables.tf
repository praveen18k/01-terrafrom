variable "vpc" {
  default = "10.0.0.0/16"
}

variable "enable_dns_hostnames" {
  default = true
}

variable "enable_dns_support" {
  default = true
}

variable "public_subnet1" {
  default = "10.0.1.0/24", "10.0.2.0/24"
}

variable "private_subnet1" {
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "azs" {
  type    = list(any)
  default = ["us-east-1a", "us-east-1b"]
}

variable "vpc_tags" {
  type = map(any)
  default = {
    name    = "vpc"
    project = "mycareer"
  }
}


