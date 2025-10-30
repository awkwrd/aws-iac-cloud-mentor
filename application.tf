resource "aws_launch_template" "cmtr_fvj3554p_template" {
  name          = local.launch_template_name
  image_id      = var.ami_id
  instance_type = var.instance_type

  iam_instance_profile {
    name = "cmtr-fvj3554p-instance_profile"
  }

  network_interfaces {
    associate_public_ip_address = true
    delete_on_termination       = true
    security_groups             = [local.ec2_security_group_id, local.http_security_group_id]
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "optional"
  }

  user_data = <<-EOT
    #!/bin/bash
    yum update -y
    yum install -y aws-cli httpd jq
    systemctl enable httpd
    systemctl start httpd

    INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
    PRIVATE_IP=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)

    echo "This message was generated on instance $INSTANCE_ID with the following IP: $PRIVATE_IP" > /var/www/html/index.html
  EOT

  tags = var.tags
}