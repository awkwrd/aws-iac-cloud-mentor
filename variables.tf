# SSH Key variable
variable "ssh_key" {
  description = "Provides custom public SSH key."
  type        = string
}

# EC2 instance type
variable "instance_type" {
  description = "Instance type for the EC2 instance."
  type        = string
}

# Security group name
variable "security_group_name" {
  description = "Name of the security group to associate with the EC2 instance."
  type        = string
}

# Project tag
variable "project_tag" {
  description = "Project tag for resource tracking."
  type        = string
}

# ID tag
variable "id_tag" {
  description = "ID tag for resource tracking."
  type        = string
}

# AMI filters for dynamic lookup
variable "ami_name_filter" {
  description = "Filter for the AMI name to dynamically fetch the latest AMI ID."
  type        = string
  default     = "amzn2-ami-hvm-*-x86_64-gp2" # Default to Amazon Linux 2 AMI
}

variable "ami_owner" {
  description = "Owner ID for the AMI to dynamically fetch the latest AMI ID."
  type        = string
  default     = "137112412989" # Default to Amazon's official owner ID
}