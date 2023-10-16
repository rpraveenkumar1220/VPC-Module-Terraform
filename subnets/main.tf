resource "aws_subnet" "subnet" {
  count = length(var.cidr_block)
  vpc_id     = var.vpc_id
  cidr_block = element(var.cidr_block,count.index)

  tags = {
    Name = "${var.env}-${var.subnet_name}-subnet"
  }
  availability_zone = "${var.az}"

  }