data "aws_vpc" "cmtr_fvj3554p_vpc" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name_tag]
  }
}

data "aws_subnets" "public_subnets" {
  filter {
    name   = "tag:aws:cloudformation:stack-name"
    values = ["cmtr-fvj3554p-stack"]
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.cmtr_fvj3554p_vpc.id]
  }
}

data "aws_subnets" "private_subnets" {
  filter {
    name   = "tag:aws:cloudformation:stack-name"
    values = ["cmtr-fvj3554p-stack"]
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.cmtr_fvj3554p_vpc.id]
  }
}

data "aws_security_group" "ec2_sg" {
  filter {
    name   = "tag:Name"
    values = [var.ec2_security_group_name]
  }
}

data "aws_security_group" "http_sg" {
  filter {
    name   = "tag:Name"
    values = [var.http_security_group_name]
  }
}

data "aws_security_group" "load_balancer_sg" {
  filter {
    name   = "tag:Name"
    values = [var.load_balancer_security_group_name]
  }
}