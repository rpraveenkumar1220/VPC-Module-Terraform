resource "aws_subnet" "subnet" {
  count = length(var.cidr_block)
  vpc_id     = var.vpc_id
  cidr_block = element(var.cidr_block,count.index)
  tags = {
    Name = "${var.env}-${var.subnet_name}-subnet"
  }
  availability_zone = element(var.az,count.index )

  }


resource "aws_route_table" "route_table" {
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.env}-${var.subnet_name}-rt"
  }
}

resource "aws_route_table_association" "association" {
  count = length(aws_subnet.subnet.*.id)
  subnet_id      = element(aws_subnet.subnet.*.id, count.index)
  route_table_id = aws_route_table.route_table.id
}
