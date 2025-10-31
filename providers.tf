terraform {
  backend "s3" {
    bucket = "cmtr-fvj3554p-backend-new-bucket-1761917529"
    key    = "tf_code.tfstate"
    region = "us-east-1"
  }
}