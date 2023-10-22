variable "ami_id" {}

variable "instance_type" {}

variable "vpc_name" { 
  type = string
}

variable "cidr_block" {
  description = "CIDR block for VPC"
  type = string
}
variable "enable_dns_support" {
  description = "Enable DNS support in the VPC"
  type        = bool
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in the VPC"
  type        = bool
}

variable "availability_zones" {
  type        = list(string)
  description = "List of Availability Zones"
}

variable "public_subnet_cidr_blocks" {
  type        = list(string)
  description = "CIDR blocks for public subnets"
}

variable "private_subnet_cidr_blocks" {
  type        = list(string)
  description = "CIDR blocks for application private subnets"
}

variable "private_dbsubnet_cidr_blocks" {
  type = list(string)
}

variable "enable_nat_gateway" {
  type = bool  
}
variable "enable_vpn_gateway" {
  type = bool
}

variable "username" {
  type = string
}

variable "password" {
  type = string
}

variable "region" {
  type = string
}