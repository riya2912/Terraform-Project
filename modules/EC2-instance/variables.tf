variable "ami_id" {
  description = "The ID of the AMI to use for EC2 instance"
}

variable "instance_type" {
  description = "The instance type for the EC2 instance."
}

variable "vpc_id" {}

variable "private_subnet_cidr_blocks" {
  type        = list(string)
  description = "CIDR blocks for application private subnets"
}

