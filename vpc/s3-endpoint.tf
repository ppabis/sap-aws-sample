resource "aws_vpc_endpoint" "s3" {
  vpc_id       = aws_vpc.SAP.id
  service_name = "com.amazonaws.${var.region}.s3"
  route_table_ids = [
    aws_route_table.private-rtb.id,
    aws_route_table.public-rtb.id
  ]
  tags = {
    Name = "s3-endpoint-${var.VPC-name}"
  }
}
