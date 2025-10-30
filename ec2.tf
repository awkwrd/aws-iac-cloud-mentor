# Fetch the latest Amazon Linux 2 AMI ID in the us-east-1 region
data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = [var.ami_name_filter]
  }

  filter {
    name   = "owner-id"
    values = [var.ami_owner]
  }

  owners = [var.ami_owner]
}

# AWS EC2 Instance Resource
resource "aws_instance" "ec2" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.keypair.key_name
  subnet_id              = aws_subnet.main.id
  vpc_security_group_ids = [aws_security_group.main.id]

  tags = {
    Name    = "${var.id_tag}-ec2"
    Project = var.project_tag
    ID      = var.id_tag
  }
}