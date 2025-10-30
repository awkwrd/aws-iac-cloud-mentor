variable "aws_region" {
  description = "AWS region where resources will be deployed"
  type        = string
  default     = "us-east-1"
}

variable "vpc_name_tag" {
  description = "Tag name of the pre-configured VPC"
  type        = string
  default     = "cmtr-fvj3554p-vpc"
}

variable "public_subnet_cidr_tags" {
  description = "Tag names for public subnets"
  type        = list(string)
  default     = ["public_subnet_cidr_a", "public_subnet_cidr_b"]
}

variable "private_subnet_cidr_tags" {
  description = "Tag names for private subnets"
  type        = list(string)
  default     = ["private_subnet_cidr_a", "private_subnet_cidr_b"]
}

variable "ec2_security_group_name" {
  description = "Tag name of the EC2 security group"
  type        = string
  default     = "cmtr-fvj3554p-ec2_sg"
}

variable "http_security_group_name" {
  description = "Tag name of the HTTP security group"
  type        = string
  default     = "cmtr-fvj3554p-http_sg"
}

variable "load_balancer_security_group_name" {
  description = "Tag name of the Load Balancer security group"
  type        = string
  default     = "cmtr-fvj3554p-sglb"
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    Terraform = "true"
    Project   = "cmtr-fvj3554p"
  }
}

variable "ami_id" {
  description = "The AMI ID to use for the EC2 instance"
  type        = string
  default     = "ami-09e6f87a47903347c" # Default AMI ID
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ssh_key_name" {
  description = "Name of the SSH key pair to use for EC2 instances"
  type        = string
  default     = "cmtr-fvj3554p-keypair" # Default SSH Key Pair
}

variable "iam_instance_profile" {
  description = "IAM Instance Profile for EC2 instances"
  type        = string
  default     = "cmtr-fvj3554p-instance_profile" # Default IAM Instance Profile
}