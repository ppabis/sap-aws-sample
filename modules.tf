
module "vpc" {
  source   = "./vpc"
  VPC-cidr = "10.65.0.0/16"
  VPC-name = "SAP-VPC"
}
