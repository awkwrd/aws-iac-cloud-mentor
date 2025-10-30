variable "aws_region" {
  description = "AWS region where resources will be deployed"
  type        = string
  default     = "us-east-1"
}

variable "ami_id" {
  description = "Amazon Machine Image (AMI) ID for the instances"
  type        = string
  default     = "ami-09e6f87a47903347c"
}

variable "instance_type" {
  description = "Instance type for the EC2 instances"
  type        = string
  default     = "t3.micro"
}

variable "ssh_key_name" {
  description = "Name of the SSH key pair to use for EC2 instances"
  type        = string
}

variable "vpc_id" {
  description = "ID of the pre-configured VPC"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnets for the Application Load Balancer"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnets for the Auto Scaling Group"
  type        = list(string)
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    Terraform = "true"
    Project   = "cmtr-fvj3554p"
  }
}