resource "aws_vpc" "main" {
  cidr_block          = var.cidr_block
  enable_dns_support  = true

  tags = {
    Name = "${var.env}-vpc"
  }
}

module "subnets" {
  source = "./subnets"
  for_each = var.subnets
 vpc_id = aws_vpc.main.id
  cidr_block = each.value["cidr_block"]
  subnet_name = each.key
  env =var.env
}


resource "aws_vpc_peering_connection" "peer" {
  peer_vpc_id   = aws_vpc.main.id
  vpc_id        = var.default_vpc_id
  auto_accept   = true

  tags = {
    Name = "defaul-vpc to ${var.env}-vpc "
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.env}-vpc-igw"
  }
}


resource "aws_route" "route-igw" {
  route_table_id            = module.subnets["public"].route_table_ids
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id

}


