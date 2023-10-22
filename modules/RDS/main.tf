resource "aws_db_instance" "tf-db-instance" {  
  allocated_storage    = 10
  db_name              = "my-tf-db"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t2.micro"
  username             = var.username
  password             = var.password
  db_subnet_group_name   = aws_db_subnet_group.tf-db_subnet_group.name
}

# Define a DB subnet group for the RDS instance
resource "aws_db_subnet_group" "tf-db_subnet_group" {
  name       = "tf-subnet-group"
  subnet_ids = var.private_dbsubnet_cidr_blocks[*]  # Replace with your subnet IDs
}

