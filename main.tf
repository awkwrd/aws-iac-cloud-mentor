provider "aws" {
  region = var.region
}

# Fetch the latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"] # Amazon Linux 2 AMI pattern
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"] # Amazon's official account ID for Amazon Linux AMIs
}

# Fetch public subnets dynamically based on tags or VPC ID
data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }

  filter {
    name   = "tag:Name"
    values = ["cmtr-fvj3554p-public-subnet*"]
  }
}

# Use the IDs of the fetched subnets
locals {
  public_subnet_ids = data.aws_subnets.public.ids
}

# Fetch the pre-provisioned security group for the load balancer
data "aws_security_group" "lb" {
  filter {
    name   = "tag:Name" # Filter by the "Name" tag
    values = ["cmtr-fvj3554p-sg-lb"]
  }
}

# Fetch the pre-provisioned security group for HTTP access
data "aws_security_group" "http" {
  filter {
    name   = "tag:Name" # Filter by the "Name" tag
    values = ["cmtr-fvj3554p-sg-http"]
  }
}

# Fetch the pre-provisioned security group for SSH access
data "aws_security_group" "ssh" {
  filter {
    name   = "tag:Name" # Filter by the "Name" tag
    values = ["cmtr-fvj3554p-sg-ssh"]
  }
}

# Application Load Balancer
resource "aws_lb" "main" {
  name               = "cmtr-fvj3554p-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [data.aws_security_group.lb.id]
  subnets            = local.public_subnet_ids
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "forward"

    forward {
      target_group {
        arn    = aws_lb_target_group.blue.arn
        weight = var.blue_weight
      }

      target_group {
        arn    = aws_lb_target_group.green.arn
        weight = var.green_weight
      }
    }
  }
}

# Target Groups
resource "aws_lb_target_group" "blue" {
  name     = "cmtr-fvj3554p-blue-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group" "green" {
  name     = "cmtr-fvj3554p-green-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

# Launch Templates
resource "aws_launch_template" "blue" {
  name          = "cmtr-fvj3554p-blue-template"
  instance_type = var.blue_instance_type
  image_id      = data.aws_ami.amazon_linux.id
  key_name      = aws_key_pair.ssh_key.key_name

  network_interfaces {
    associate_public_ip_address = true
    security_groups = [
      data.aws_security_group.http.id, # HTTP security group
      data.aws_security_group.ssh.id   # SSH security group
    ]
  }

  user_data = base64encode(<<-EOT
              #!/bin/bash
              yum install -y httpd
              sleep 20
              mkdir -p /var/www/html
              echo "Blue Environment" > /var/www/html/index.html
              systemctl start httpd
              systemctl enable httpd
              EOT
  )
}

resource "aws_launch_template" "green" {
  name          = "cmtr-fvj3554p-green-template"
  instance_type = var.green_instance_type
  image_id      = data.aws_ami.amazon_linux.id
  key_name      = aws_key_pair.ssh_key.key_name

  network_interfaces {
    associate_public_ip_address = true
    security_groups = [
      data.aws_security_group.http.id, # HTTP security group
      data.aws_security_group.ssh.id   # SSH security group
    ]
  }

  user_data = base64encode(<<-EOT
              #!/bin/bash
              yum install -y httpd
              sleep 20
              mkdir -p /var/www/html
              echo "Green Environment" > /var/www/html/index.html
              systemctl start httpd
              systemctl enable httpd
              EOT
  )
}

# Auto Scaling Groups
resource "aws_autoscaling_group" "blue" {
  launch_template {
    id      = aws_launch_template.blue.id
    version = "$Latest"
  }

  min_size            = 1
  max_size            = 3
  desired_capacity    = 1
  vpc_zone_identifier = local.public_subnet_ids
  target_group_arns   = [aws_lb_target_group.blue.arn]
}

resource "aws_autoscaling_group" "green" {
  launch_template {
    id      = aws_launch_template.green.id
    version = "$Latest"
  }

  min_size            = 1
  max_size            = 3
  desired_capacity    = 1
  vpc_zone_identifier = local.public_subnet_ids
  target_group_arns   = [aws_lb_target_group.green.arn]
}