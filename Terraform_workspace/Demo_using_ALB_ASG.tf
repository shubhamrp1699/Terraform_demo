#step-1-logic to create aws asg
resource "aws_autoscaling_group" "asgphpdemo" {   
  name                      = "asgphpdemo"
  max_size                  = 2
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 1
  force_delete              = true
  launch_configuration      = aws_launch_configuration.as_conf.name
  vpc_zone_identifier       = ["subnet-6875e913", "subnet-9f0b5ed3", "subnet-79cd2912"]
  target_group_arns         = [aws_alb_target_group.phpalbtarget.arn]      
}
#step2 - create load balancer
resource "aws_alb" "albphpdemo" {
  name               = "albphpdemo"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["sg-016e6eaab63f75a17"]
  subnets            = ["subnet-6875e913", "subnet-9f0b5ed3", "subnet-79cd2912"]
}

resource "aws_alb_target_group" "phpalbtarget" {
  name     = "phpalbtarget"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-d13ac5ba"
  health_check {
    port     = 80
    protocol = "HTTP"
  }
}

resource "aws_alb_listener" "front_end" {
  load_balancer_arn = aws_alb.albphpdemo.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.phpalbtarget.arn
  }
}