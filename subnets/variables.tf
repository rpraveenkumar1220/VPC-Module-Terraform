variable "vpc_id" {}
variable "cidr_block" {}
variable "env" {}
variable "subnet_name" {}
variable "az" {
  default = [ "us-east-1a" , "us-east-1b"]
}

