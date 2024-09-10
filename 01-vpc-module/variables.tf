variable "vpc" {
  default = "10.0.0.0/16"
}

variable "public_subnet1" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet1" {
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "vpc_tags" {
  type = map(any)
  default = {
    name    = "vpc"
    project = "mycareer"
  }
}

      
