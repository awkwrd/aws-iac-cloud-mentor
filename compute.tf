resource "aws_instance" "ec2_instance" {
  ami           = "ami-0c55b159cbfafe1f0" # Replace with a valid AMI ID for your region
  instance_type = "t2.micro"

  subnet_id       = data.terraform_remote_state.base_infra.outputs.public_subnet_id
  security_groups = [data.terraform_remote_state.base_infra.outputs.security_group_id]

  tags = {
    Terraform = "true"
    Project   = var.project_id
  }
}