variable "username" {
  type = string
}

variable "password" {
  type = string
}
variable "availability_zones" {
  type        = list(string)
  description = "List of Availability Zones"
}

variable "private_dbsubnet_cidr_blocks" {
  type = list(string)
}