variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

variable "project_prefix" {
  description = "The prefix for all resource names"
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "subnets" {
  description = "List of public subnets with their CIDR blocks and availability zones"
  type = list(object({
    name              = string
    cidr_block        = string
    availability_zone = string
  }))
}

variable "internet_gateway_suffix" {
  description = "The suffix for the Internet Gateway name"
  type        = string
}

variable "routing_table_suffix" {
  description = "The suffix for the Routing Table name"
  type        = string
}
