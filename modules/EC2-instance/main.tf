resource "aws_instance" "ec2-instance" {
    ami = var.ami_id
    instance_type = var.instance_type
}