# Create an ALB (Application Load Balancer)
resource "aws_lb" "alb" {
  name               = "my-tf-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [for subnet in var.cidr_block : subnet.id] # Replace with your subnets
}

# Create an ALB instance target group
resource "aws_lb_target_group" "tg" {
  name     = "my-tf-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  } 

resource "aws_lb_target_group_attachment" "alb-attachment" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = var.instance_id
}