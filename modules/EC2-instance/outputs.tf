output "public_ip" {
  value = aws_instance.my-tf-instance.public_ip
}

output "instance_id" {
  value = aws_instance.my-tf-instance.id
}




