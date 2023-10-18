
output "vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "aws_internet_gateway" {
  value = aws_internet_gateway.internet_gateway.id
}

output "aws_pub_subnet" {
  value = aws_subnet.public_subnet[*].id
}

output "aws_Pri_subnet" {
  value = aws_subnet.private_subnets[*].id
}


