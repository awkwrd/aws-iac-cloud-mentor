

# Application Load Balancer
resource "aws_lb" "main" {
  name               = "${var.project_name}-lb"
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
  name     = "${var.project_name}-blue-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.selected.id
}

resource "aws_lb_target_group" "green" {
  name     = "${var.project_name}-green-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.selected.id
}

# Launch Templates
resource "aws_launch_template" "blue" {
  name          = "${var.project_name}-blue-template"
  instance_type = var.blue_instance_type
  image_id      = data.aws_ami.amazon_linux.id

  network_interfaces {
    associate_public_ip_address = true
    security_groups = [
      data.aws_security_group.http.id,
      data.aws_security_group.ssh.id
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
  name          = "${var.project_name}-green-template"
  instance_type = var.green_instance_type
  image_id      = data.aws_ami.amazon_linux.id

  network_interfaces {
    associate_public_ip_address = true
    security_groups = [
      data.aws_security_group.http.id,
      data.aws_security_group.ssh.id
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