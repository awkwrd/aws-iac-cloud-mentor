resource "aws_security_group" "ssh_sg" {
  name        = "cmtr-fvj3554p-ssh-sg"
  description = "Security group for SSH access."
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ip_range
  }

  ingress {
    description = "Allow ICMP access"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = var.allowed_ip_range
  }

  tags = {
    Project = var.project
  }
}

resource "aws_security_group" "public_http_sg" {
  name        = "cmtr-fvj3554p-public-http-sg"
  description = "Security group for public HTTP access."
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow HTTP access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.allowed_ip_range
  }

  ingress {
    description = "Allow ICMP access"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = var.allowed_ip_range
  }

  tags = {
    Project = var.project
  }
}

resource "aws_security_group" "private_http_sg" {
  name        = "cmtr-fvj3554p-private-http-sg"
  description = "Security group for private HTTP access."
  vpc_id      = var.vpc_id

  tags = {
    Project = var.project
  }
}

resource "aws_security_group_rule" "private_http_sg_http" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = aws_security_group.private_http_sg.id
  source_security_group_id = aws_security_group.public_http_sg.id
}

resource "aws_security_group_rule" "private_http_sg_icmp" {
  type                     = "ingress"
  from_port                = -1
  to_port                  = -1
  protocol                 = "icmp"
  security_group_id        = aws_security_group.private_http_sg.id
  source_security_group_id = aws_security_group.public_http_sg.id
}

resource "aws_network_interface_sg_attachment" "public_instance_ssh" {
  security_group_id    = aws_security_group.ssh_sg.id
  network_interface_id = data.aws_instance.public_instance.network_interface_id
}

resource "aws_network_interface_sg_attachment" "public_instance_http" {
  security_group_id    = aws_security_group.public_http_sg.id
  network_interface_id = data.aws_instance.public_instance.network_interface_id
}

resource "aws_network_interface_sg_attachment" "private_instance_ssh" {
  security_group_id    = aws_security_group.ssh_sg.id
  network_interface_id = data.aws_instance.private_instance.network_interface_id
}

resource "aws_network_interface_sg_attachment" "private_instance_http" {
  security_group_id    = aws_security_group.private_http_sg.id
  network_interface_id = data.aws_instance.private_instance.network_interface_id
}

data "aws_instance" "public_instance" {
  instance_id = var.public_instance_id
}

data "aws_instance" "private_instance" {
  instance_id = var.private_instance_id
}