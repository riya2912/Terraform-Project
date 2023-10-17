terraform {
  backend "s3" {
    bucket = "my-terraform-bucket2912"
    key    = "terraform/terraform.tfstate"
    region = "eu-west-2"
    dynamodb_table = "my-DynamoDB-table2912"
  }
}