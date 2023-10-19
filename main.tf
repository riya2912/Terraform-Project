module "EC2-instance" {
  source      = "./modules/EC2-instance"
  ami_id      = var.ami_id
  instance_type = var.instance_type
}

module "VPC" {
  source     = "./modules/VPC"
  vpc_name   = var.vpc_name
  cidr_block = var.cidr_block
  enable_dns_support = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_nat_gateway = var.enable_nat_gateway
  enable_vpn_gateway = var.enable_vpn_gateway
  availability_zones = var.availability_zones
  public_subnet_cidr_blocks = var.public_subnet_cidr_blocks
  private_subnet_cidr_blocks = var.private_subnet_cidr_blocks
}



