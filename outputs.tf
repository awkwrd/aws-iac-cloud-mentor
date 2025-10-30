output "bucket_name" {
  description = "The name of the S3 bucket created."
  value       = aws_s3_bucket.storage_bucket.bucket
}

output "bucket_region" {
  description = "The AWS region where the S3 bucket is created."
  value       = var.region
}