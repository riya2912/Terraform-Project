## The AWS VPC module automates the provisioning of a Virtual Private Cloud along with public and private subnets. It simplifies the process of setting up a network architecture on AWS. The module creates the following resources:

# Terraform Configuration

VPC
The aws_vpc resource defines the AWS Virtual Private Cloud (VPC) and its basic settings, such as CIDR block, DNS support, and DNS hostnames. The VPC is tagged with the provided var.vpc_name.

Internet Gateway
The aws_internet_gateway resource creates an internet gateway and attaches it to the VPC. It is tagged with the name "Internet Gateway."

Public Subnets
The aws_subnet resource creates public subnets for web servers in each specified availability zone. These subnets have public IP address mapping enabled, which allows instances in these subnets to communicate with the internet.

Private Application Subnets
The aws_subnet resource creates private subnets for application servers in each specified availability zone. These subnets do not have direct internet access, making them suitable for application servers that should not be directly exposed to the internet.

Private Database Subnets
The aws_subnet resource creates private subnets for database servers in each specified availability zone. Similar to the private application subnets, these subnets do not have direct internet access and are suitable for database servers.

Public Route Tables
The aws_route_table resource defines route tables for the public subnets. It associates these route tables with the internet gateway, allowing instances in public subnets to access the internet.

Private Route Tables
The aws_route_table resource defines route tables for the private application subnets. These route tables are associated with a NAT gateway (to be created later), which allows instances in private subnets to initiate outbound connections to the internet.

Route Table Associations
The aws_route_table_association resource associates the defined route tables with the respective subnets.

Elastic IP and NAT Gateway
The aws_eip resource allocates an Elastic IP (EIP) that will be associated with the NAT gateway. The aws_nat_gateway resource creates a NAT gateway and associates it with a public subnet for outbound internet access for the private subnets.