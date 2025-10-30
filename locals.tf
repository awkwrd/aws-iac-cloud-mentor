locals {
  launch_template_name = "cmtr-fvj3554p-template"
  asg_name             = "cmtr-fvj3554p-asg"
  alb_name             = "cmtr-fvj3554p-loadbalancer"

  # Ensure subnets are in different Availability Zones
  public_subnets  = distinct([for subnet in data.aws_subnets.public_subnets.ids : subnet])
  private_subnets = distinct([for subnet in data.aws_subnets.private_subnets.ids : subnet])

  ec2_security_group_id           = data.aws_security_group.ec2_sg.id
  http_security_group_id          = data.aws_security_group.http_sg.id
  load_balancer_security_group_id = data.aws_security_group.load_balancer_sg.id
}