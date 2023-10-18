resource "aws_vpc" "my_vpc" {
  cidr_block           = var.cidr_block
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public_subnet" {
  count         = length(var.availability_zones)
  vpc_id        = aws_vpc.my_vpc.id
  cidr_block    = var.public_subnet_cidr_blocks[count.index]
  availability_zone = var.availability_zones[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "Public Subnet"
  }
}

resource "aws_subnet" "private_subnets" {
  count         = length(var.availability_zones)
  vpc_id        = aws_vpc.my_vpc.id
  cidr_block    = var.private_subnet_cidr_blocks[count.index]
  availability_zone = var.availability_zones[count.index]
  tags = {
    Name = "Private Subnet"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "Internet Gateway"
  }
}

resource "aws_route_table" "public_route_tables" {
  count = length(aws_subnet.public_subnet)
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
  count = length(aws_subnet.private_subnets)
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "Private Route Table"
  }
}

resource "aws_route_table_association" "publicRTassociation" {
  count           = length(aws_subnet.public_subnet)
  subnet_id       = aws_subnet.public_subnet[count.index].id
  route_table_id  = aws_route_table.public_route_tables[count.index].id
}

resource "aws_route_table_association" "privateRTassociation" {
  count           = length(aws_subnet.private_subnets)
  subnet_id       = aws_subnet.private_subnets[count.index].id
  route_table_id  = aws_route_table.private_route_tables[count.index].id
}
