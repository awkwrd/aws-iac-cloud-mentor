output "vpc_id" {
  description = "The ID of the created VPC"
  value       = aws_vpc.main.id
}

output "subnet_ids" {
  description = "The IDs of the created public subnets"
  value       = [for subnet in aws_subnet.public_subnets : subnet.id]
}

output "internet_gateway_id" {
  description = "The ID of the created Internet Gateway"
  value       = aws_internet_gateway.igw.id
}

output "route_table_id" {
  description = "The ID of the created route table"
  value       = aws_route_table.public.id
}
