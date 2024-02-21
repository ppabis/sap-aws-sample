resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.SAP.id
}

resource "aws_subnet" "public" {
  for_each = {
    "a" : 5,
    "b" : 6
  }
  vpc_id                  = aws_vpc.SAP.id
  cidr_block              = cidrsubnet(aws_vpc.SAP.cidr_block, 8, each.value)
  availability_zone       = "${var.region}${each.key}"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-${each.key}-${var.VPC-name}"
  }
}

resource "aws_route_table" "public-rtb" {
  vpc_id = aws_vpc.SAP.id
  tags   = { Name = "public-rtb-${var.VPC-name}" }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }
}

resource "aws_route_table_association" "public" {
  for_each       = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public-rtb.id
}
