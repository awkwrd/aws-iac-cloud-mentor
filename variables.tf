variable "allowed_ip_range" {
  description = "List of IP address ranges for secure access."
  type        = list(string)
}

variable "vpc_id" {
  description = "ID of the VPC."
  type        = string
}

variable "public_instance_id" {
  description = "ID of the public EC2 instance."
  type        = string
}

variable "private_instance_id" {
  description = "ID of the private EC2 instance."
  type        = string
}

variable "public_subnet_id" {
  description = "ID of the public subnet."
  type        = string
}

variable "private_subnet_id" {
  description = "ID of the private subnet."
  type        = string
}

variable "project" {
  description = "The project ID for tagging resources."
  type        = string
}