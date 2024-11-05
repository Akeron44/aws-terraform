variable "private_subnet_id" {
  description = "The id of the private subnet"
  type        = string
}

variable "public_subnet_id" {
  description = "The id of the private subnet"
  type        = string
}

variable "vpc_id" {
  description = "The id of the vpc"
  type        = string
}

variable "public_ec2_id" {
  description = "The id of the ec2 in the public subnet"
  type        = string
}

variable "private_ec2_id" {
  description = "The id of the ec2 in the private subnet"
  type        = string
}
variable "security_group_id" {
  description = "The id of the security group"
  type        = string
}
