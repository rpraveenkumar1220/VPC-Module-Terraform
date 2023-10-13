resource "aws_vpc" "vpc" {
  cidr_block          = var.cidr_block
  enable_dns_support  = true

  tags = {
    Name = "${env}-vpc"
  }
}