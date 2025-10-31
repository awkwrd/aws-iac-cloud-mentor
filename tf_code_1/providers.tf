terraform {
  backend "s3" {
    bucket = "bucket=cmtr-fvj3554p-backend-bucket-1761915235"
    key    = "tf_code_1.tfstate"
    region = "us-east-1"
  }
}