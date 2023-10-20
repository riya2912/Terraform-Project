
output "vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "aws_internet_gateway" {
  value = aws_internet_gateway.internet_gateway.id
}

output "aws_pub_subnet" {
  value = aws_subnet.public_web_subnet[*].id
}

output "aws_Pri_app_subnet" {
  value = aws_subnet.private_app_subnets[*].id
}

output "aws_Pri_DB_subnet" {
  value = aws_subnet.private_db_subnets[*].id
}