resource "aws_vpc" "SAP" {
  cidr_block           = var.VPC-cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags                 = { Name = var.VPC-name }
}
