module "EC2-instance" {
  source      = "./modules/EC2-instance"
  ami_id      = var.ami_id
  instance_type = var.instance_type
  vpc_id = module.VPC.vpc_id
  private_subnet_cidr_blocks = module.VPC.aws_Pri_app_subnet
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
  private_dbsubnet_cidr_blocks = var.private_dbsubnet_cidr_blocks
  nat_gateway_id = module.NAT-GW.nat_gateway_id
  
}

module "RDS" {
  source = "./modules/RDS"
  username = var.username
  password = var.password
  availability_zones = var.availability_zones
  private_dbsubnet_cidr_blocks = module.VPC.aws_pri_db_subnet
}

module "NAT-GW" {
  source = "./modules/NAT-GW"
  cidr_block = module.VPC.aws_pub_subnet.id
}

module "Security-Group" {
  source = "./modules/Security-Group"
}

module "ALB" {
  source = "./modules/ALB"
  vpc_id = module.VPC.vpc_id
  instance_id = module.EC2-instance.instance_id
  cidr_block = module.VPC.aws_Pri_app_subnet.id
}