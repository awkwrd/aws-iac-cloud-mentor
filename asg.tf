resource "aws_autoscaling_group" "cmtr_fvj3554p_asg" {
  name             = local.asg_name
  max_size         = 2
  min_size         = 1
  desired_capacity = 2
  launch_template {
    id      = aws_launch_template.cmtr_fvj3554p_template.id
    version = "$Latest"
  }

  lifecycle {
    ignore_changes = [load_balancers, target_group_arns]
  }

  tag {
    key                 = "Name"
    value               = local.asg_name
    propagate_at_launch = true
  }

  dynamic "tag" {
    for_each = var.tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}