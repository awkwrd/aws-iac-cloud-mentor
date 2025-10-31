output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.cmtr_fvj3554p_instance.id
}

output "instance_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.cmtr_fvj3554p_instance.public_ip
}

output "security_group_id" {
  description = "The ID of the discovered security group"
  value       = data.aws_security_group.selected.id
}