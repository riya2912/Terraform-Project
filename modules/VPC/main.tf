# create VPC
resource "aws_vpc" "my_vpc" {
  cidr_block           = var.cidr_block
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  tags = {
    Name = var.vpc_name
  }
}

# create internet gateway and attach it to VPC
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "Internet Gateway"
  }
}

# create public subnets for web
resource "aws_subnet" "public_web_subnet" {
  count         = length(var.availability_zones)
  vpc_id        = aws_vpc.my_vpc.id
  cidr_block    = var.public_subnet_cidr_blocks[count.index]
  availability_zone = var.availability_zones[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "Public Subnet"
  }
}

# create private subnets for application 
resource "aws_subnet" "private_app_subnets" {
  count         = length(var.availability_zones)
  vpc_id        = aws_vpc.my_vpc.id
  cidr_block    = var.private_subnet_cidr_blocks[count.index]
  availability_zone = var.availability_zones[count.index]
  tags = {
    Name = "Private application Subnet"
  }
}

# create private subnets for database 
resource "aws_subnet" "private_db_subnets" {
  count         = length(var.availability_zones)
  vpc_id        = aws_vpc.my_vpc.id
  cidr_block    = var.private_subnet_cidr_blocks[count.index]
  availability_zone = var.availability_zones[count.index]
  tags = {
    Name = "Private database Subnet"
  }
}

resource "aws_route_table" "public_route_tables" {
  count = length(aws_subnet.public_web_subnet)
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
  tags = {
    Name = "Public Route Table"
  }  
}

resource "aws_route_table" "private_route_tables" {
  count = length(aws_subnet.private_app_subnets)
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }
  tags = {
    Name = "Private Route Table"
  }
}

resource "aws_route_table_association" "publicRTassociation" {
  count           = length(aws_subnet.public_web_subnet)
  subnet_id       = aws_subnet.public_web_subnet[count.index].id
  route_table_id  = aws_route_table.public_route_tables[count.index].id
}

resource "aws_route_table_association" "privateRTassociation" {
  count           = length(aws_subnet.private_app_subnets)
  subnet_id       = aws_subnet.private_app_subnets[count.index].id
  route_table_id  = aws_route_table.private_route_tables[count.index].id
}


resource "aws_eip" "eip" {
  domain   = "vpc"
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public_web_subnet[0].id
  tags = {
    Name = "gw NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  //depends_on = [aws_internet_gateway.example]
}