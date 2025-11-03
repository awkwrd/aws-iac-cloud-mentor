variable "region" {
  description = "The AWS region to deploy resources in."
  type        = string
}

variable "vpc_id" {
  description = "The ID of the pre-provisioned VPC."
  type        = string
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
}

variable "green_instance_type" {
  description = "The instance type for the Green environment."
  type        = string
}

variable "project_name" {
  description = "The name of the project used for tagging and naming resources."
  type        = string
}