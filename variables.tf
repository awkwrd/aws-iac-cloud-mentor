variable "region" {
  description = "The AWS region to deploy resources in."
  type        = string
  default     = "us-east-1"
}

variable "vpc_id" {
  description = "The ID of the pre-provisioned VPC."
  type        = string
  default     = "vpc-07dca5b53ee29ccbf"
}

variable "blue_weight" {
  description = "The traffic weight for the Blue Target Group."
  type        = number
}

variable "green_weight" {
  description = "The traffic weight for the Green Target Group."
  type        = number
}

variable "blue_instance_type" {
  description = "The instance type for the Blue environment."
  type        = string
  default     = "t2.micro"
}

variable "green_instance_type" {
  description = "The instance type for the Green environment."
  type        = string
  default     = "t2.micro"
}

variable "project_name" {
  description = "The name of the project used for tagging and naming resources."
  type        = string
  default     = "cmtr-fvj3554p"
}