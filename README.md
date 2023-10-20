# Highly Available Web Application Architecture on AWS with Terraform

This Terraform project deploys a highly available 3-tier web application architecture on AWS, using modules for better organization. It includes Amazon EC2 instances, Auto Scaling, Elastic Load Balancing, and a Virtual Private Cloud (VPC).

## Table of Contents

- [Prerequisites](#prerequisites)
- [Directory Structure](#directory-structure)
- [Configuration](#configuration)
- [Deployment](#deployment)
- [Cleanup](#Cleanup)

## Prerequisites

Before getting started, make sure you have the following in place:

- [Terraform](https://www.terraform.io/downloads.html) installed on your local machine.
- AWS credentials configured with necessary permissions.

## Directory Structure

The project is structured as follows:

- `main.tf`: The main Terraform configuration file that defines modules and resources.
- `variables.tf`: Variable definitions for the project.
- `outputs.tf`: Output variables that provide information about the resources created.
- `providers.tf`: Configuration for the AWS provider.
- `terraform.tfvars`: Configuration values.
- `modules/`: Submodules for VPC and EC2.
- `userdata.sh`: This file contains user data scripts that are executed when an EC2 instance is launched. User data is commonly used for initialization and configuration of instances.
- `id_rsa.pub`: This is the public key of an SSH key pair used for securely accessing EC2 instances.
- `.gitignore`: This file is to exclude sensitive or generated files that don't need to be version-controlled. 

## Configuration

Before deploying, configure the `terraform.tfvars` file with your specific values

## Deployment

1. Initialize the Terraform project:
   
   `terraform init`

2. View the execution plan to verify the changes:

   `terraform plan`

3. Deploy the infrastructure:

   `terraform apply`

4. Confirm the deployment by typing `yes`.

## Cleanup

Run below command to destroy your infrastructure:

   `terraform destroy`
