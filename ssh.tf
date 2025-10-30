resource "aws_key_pair" "keypair" {
  key_name   = "${var.id_tag}-keypair"
  public_key = var.ssh_key

  tags = {
    Project = var.project_tag
    ID      = var.id_tag
  }
}