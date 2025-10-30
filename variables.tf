variable "project" {
  description = "Project name for tagging resources"
  type        = string
  default     = "cmtr-fvj3554p"
}

variable "s3_bucket_name" {
  description = "Name of the S3 bucket to configure access for"
  type        = string
  default     = "cmtr-fvj3554p-bucket-1761821479"
}