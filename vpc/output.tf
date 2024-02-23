output "VPC-id" {
  value = aws_vpc.SAP.id
}

output "public-subnet-ids" {
  value = [for s in aws_subnet.public : s.id]
}

output "private-subnet-ids" {
  value = [for s in aws_subnet.private : s.id]
}

output "private-rtb-id" {
  value = aws_route_table.private-rtb.id
}
