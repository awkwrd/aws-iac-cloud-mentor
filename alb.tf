resource "aws_lb" "cmtr_fvj3554p_loadbalancer" {
  name               = local.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [local.load_balancer_security_group_id]
  subnets            = slice(local.public_subnets, 0, 2) # Select the first two subnets

  enable_deletion_protection = false

  tags = var.tags
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.cmtr_fvj3554p_loadbalancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.cmtr_fvj3554p_target_group.arn
  }
}

resource "aws_lb_target_group" "cmtr_fvj3554p_target_group" {
  name     = "${local.alb_name}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.cmtr_fvj3554p_vpc.id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = var.tags
}

resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.cmtr_fvj3554p_asg.name
  lb_target_group_arn    = aws_lb_target_group.cmtr_fvj3554p_target_group.arn
}