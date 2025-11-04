output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.network.vpc_id
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets"
  value       = module.network.public_subnet_ids
}

output "load_balancer_dns" {
  description = "The DNS name of the load balancer"
  value       = module.application.load_balancer_dns
}