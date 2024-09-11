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
  default = list
  validation {
    condition     = length(var.public_subnet1) == 2
    error_message = "please provide 2 public subnet CIDR"
  }
}

variable "private_subnet1" {
  default = list
  validation {
    condition     = length(var.private_subnet1) == 2
    error_message = "please provide 2 private subnet CIDR"
  }
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


