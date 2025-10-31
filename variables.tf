variable "aws_region" {
  description = "AWS region for resources"
  type        = string
}

variable "project_id" {
  description = "Project identifier for tagging"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC to discover"
  type        = string
}

variable "public_subnet_name" {
  description = "Name of the public subnet to discover"
  type        = string
}

variable "security_group_name" {
  description = "Name of the security group to discover"
  type        = string
}