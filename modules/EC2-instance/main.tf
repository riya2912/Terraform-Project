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

resource "aws_key_pair" "tf-key" {
  key_name   = "terraform-key"
  public_key = file("./id_rsa.pub")
}

data "aws_instance" "instance_id" {
  instance_id = aws_instance.my-tf-instance.id
}