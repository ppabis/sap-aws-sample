
module "vpc" {
  source   = "./vpc"
  VPC-cidr = "10.65.0.0/16"
  VPC-name = "SAP-VPC"
}

module "NAT" {
  source         = "git::https://github.com/ppabis/nat-instance.git//NAT?ref=v2.0.0"
  vpc            = module.vpc.VPC-id
  public_subnet  = module.vpc.public-subnet-ids[0]
  private_subnet = module.vpc.private-subnet-ids
  route_tables   = [module.vpc.private-rtb-id]
}
