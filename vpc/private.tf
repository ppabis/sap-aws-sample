resource "aws_subnet" "private" {
  for_each = {
    "a" : 15,
    "b" : 16
  }
  vpc_id            = aws_vpc.SAP.id
  cidr_block        = cidrsubnet(aws_vpc.SAP.cidr_block, 8, each.value)
  availability_zone = "${var.region}${each.key}"
  tags = {
    Name = "private-${each.key}-${var.VPC-name}"
  }
}

resource "aws_route_table" "private-rtb" {
  vpc_id = aws_vpc.SAP.id
  tags   = { Name = "private-rtb-${var.VPC-name}" }
}

resource "aws_route_table_association" "private" {
  for_each       = aws_subnet.private
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private-rtb.id
}
