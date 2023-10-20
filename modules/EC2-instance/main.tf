# Create security Group
resource "aws_security_group" "sg" {
  name        = "my-tf-sg"
  description = "Allow HTTP and SSH traffic"
  
  # Define ingress rules for HTTP, HTTPS and SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create an ALB (Application Load Balancer)
resource "aws_lb" "alb" {
  name               = "my-tf-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [for subnet in private_app_subnets : subnet.id] # Replace with your subnets
}

# Create an ALB instance target group
resource "aws_lb_target_group" "tg" {
  name     = "my-tf-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = vpc_id.aws_vpc.my_vpc.id
  } 

# Create an EC2 instance with user data script
resource "aws_instance" "my-tf-instance" {
  ami           = var.ami_id 
  instance_type = var.instance_type
  key_name      = "${aws_key_pair.tf-key.key_name}"
  user_data     = file("${path.module}/userdata.sh")
  tags = {
    Name = "mt-tf-instance"
  }
}

resource "aws_lb_target_group_attachment" "alb-attachment" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = aws_instance.my-tf-instance.id
}

resource "aws_key_pair" "tf-key" {
  key_name   = "terraform-key"
  public_key = file("./id_rsa.pub")
}