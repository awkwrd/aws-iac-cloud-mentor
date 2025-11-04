variable "subnet_ids" {
  description = "List of subnet IDs for the application"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs for the application"
  type        = list(string)
}

variable "instance_type" {
  description = "Instance type for the launch template"
  type        = string
}

variable "desired_capacity" {
  description = "Desired capacity for the Auto Scaling Group"
  type        = number
}

variable "min_size" {
  description = "Minimum size for the Auto Scaling Group"
  type        = number
}

variable "max_size" {
  description = "Maximum size for the Auto Scaling Group"
  type        = number
}

variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "public_http_sg_id" {
  description = "The ID of the public HTTP security group"
  type        = string
}