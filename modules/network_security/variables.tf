variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "allowed_ip_range" {
  description = "List of allowed IP ranges for security groups"
  type        = list(string)
}

variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
}