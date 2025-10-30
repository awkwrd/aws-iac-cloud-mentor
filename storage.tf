provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "storage_bucket" {
  bucket = var.bucket_name

  tags = var.tags
}