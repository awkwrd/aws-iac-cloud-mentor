provider "aws" {
  region = var.region
}

module "network" {
  source           = "./modules/network"
  vpc_cidr_block   = var.vpc_cidr_block
  public_subnets   = var.public_subnets
  region           = var.region
  allowed_ip_range = var.allowed_ip_range
  name_prefix      = var.name_prefix

}

module "network_security" {
  source           = "./modules/network_security"
  vpc_id           = module.network.vpc_id
  allowed_ip_range = var.allowed_ip_range
  name_prefix      = var.name_prefix
}

module "application" {
  source             = "./modules/application"
  subnet_ids         = module.network.public_subnet_ids
  security_group_ids = [module.network_security.ssh_sg_id, module.network_security.private_http_sg_id]
  public_http_sg_id  = module.network_security.public_http_sg_id
  instance_type      = var.instance_type
  desired_capacity   = var.desired_capacity
  min_size           = var.min_size
  max_size           = var.max_size
  name_prefix        = var.name_prefix
  vpc_id             = module.network.vpc_id                              # Pass the VPC ID here
  instance_profile   = aws_iam_instance_profile.ssm_instance_profile.name # Pass the instance profile

}