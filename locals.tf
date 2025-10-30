locals {
  launch_template_name = "cmtr-fvj3554p-template"
  asg_name             = "cmtr-fvj3554p-asg"
  alb_name             = "cmtr-fvj3554p-loadbalancer"

  public_subnets                  = data.aws_subnets.public_subnets.ids
  private_subnets                 = data.aws_subnets.private_subnets.ids
  ec2_security_group_id           = data.aws_security_group.ec2_sg.id
  http_security_group_id          = data.aws_security_group.http_sg.id
  load_balancer_security_group_id = data.aws_security_group.load_balancer_sg.id
}