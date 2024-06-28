variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

variable "ami" {
  description = "The AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "The type of the EC2 instance"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet where the instance will be deployed"
  type        = string
}
