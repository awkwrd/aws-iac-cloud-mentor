resource "aws_security_group" "ssh" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ip_range
  }

  tags = {
    Name = "${var.name_prefix}-ssh-sg"
  }
}

resource "aws_security_group" "public_http" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.allowed_ip_range
  }

  tags = {
    Name = "${var.name_prefix}-public-http-sg"
  }
}

resource "aws_security_group" "private_http" {
  vpc_id = var.vpc_id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.public_http.id]
  }

  tags = {
    Name = "${var.name_prefix}-private-http-sg"
  }
}