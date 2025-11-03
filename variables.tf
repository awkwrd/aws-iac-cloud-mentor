variable "vpc_id" {
  description = "The ID of the pre-provisioned VPC."
  type        = string
}

# variable "public_subnet_ids" {
#   description = "The IDs of the pre-provisioned public subnets."
#   type        = list(string)
# }

variable "blue_weight" {
  description = "The traffic weight for the Blue Target Group. Specifies the percentage of traffic routed to the Blue environment."
  type        = number
  default     = 30
}

variable "green_weight" {
  description = "The traffic weight for the Green Target Group. Specifies the percentage of traffic routed to the Green environment."
  type        = number
  default     = 70
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

variable "region" {
  description = "The AWS region"
  type        = string
}

variable "ssh_key_name" {
  description = "The name of the SSH key pair to create."
  type        = string
  default     = "cmtr-fvj3554p-key" # Default key name
}

variable "ssh_public_key" {
  description = "The public key to use for the SSH key pair."
  type        = string
}