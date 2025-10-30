variable "bucket_name" {
  description = "The name of the S3 bucket to be created."
  type        = string
}

variable "region" {
  description = "The AWS region where the S3 bucket will be created."
  type        = string
}

variable "tags" {
  description = "Tags to apply to the S3 bucket."
  type        = map(string)
}