provider "aws" {
  region = var.aws_region
}

# No backend configuration is defined, so Terraform will use the default local backend.