output "load_balancer_dns_name" {
  description = "The DNS name of the load balancer."
  value       = aws_lb.main.dns_name
}

output "http_security_group_id" {
  description = "The ID of the HTTP security group."
  value       = data.aws_security_group.http.id
}

output "ssh_security_group_id" {
  description = "The ID of the SSH security group."
  value       = data.aws_security_group.ssh.id
}
