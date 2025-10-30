resource "aws_instance" "ec2_instance" {
  ami           = "ami-0601422bf6afa8ac3"
  instance_type = "t2.micro"

  subnet_id       = data.terraform_remote_state.base_infra.outputs.public_subnet_id
  security_groups = [data.terraform_remote_state.base_infra.outputs.security_group_id]

  tags = {
    Terraform = "true"
    Project   = var.project_id
  }
}