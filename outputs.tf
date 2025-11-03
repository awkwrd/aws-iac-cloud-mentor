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

output "private_key" {
  description = "The private key for SSH access to the instances."
  value       = tls_private_key.ssh_key.private_key_pem
  sensitive   = true
}

output "key_name" {
  description = "The name of the SSH key pair."
  value       = aws_key_pair.ssh_key.key_name
}