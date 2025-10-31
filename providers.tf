terraform {
  backend "s3" {
    bucket = "cmtr-fvj3554p-backend-bucket-1761920706"
    key    = "tf_code.tfstate"
    region = "us-east-1"
  }
}