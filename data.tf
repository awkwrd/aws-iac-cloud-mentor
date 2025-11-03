
# Fetch the VPC dynamically based on tags or default VPC
data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["${var.project_name}-vpc"]
  }
}

# Fetch the latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"]
}

# Fetch public subnets dynamically based on tags or VPC ID
data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }

  filter {
    name   = "tag:Name"
    values = ["${var.project_name}-public-subnet*"]
  }
}

locals {
  public_subnet_ids = data.aws_subnets.public.ids
}

# Fetch security groups dynamically
data "aws_security_group" "lb" {
  filter {
    name   = "tag:Name"
    values = ["${var.project_name}-sg-lb"]
  }
}

data "aws_security_group" "http" {
  filter {
    name   = "tag:Name"
    values = ["${var.project_name}-sg-http"]
  }
}

data "aws_security_group" "ssh" {
  filter {
    name   = "tag:Name"
    values = ["${var.project_name}-sg-ssh"]
  }
}