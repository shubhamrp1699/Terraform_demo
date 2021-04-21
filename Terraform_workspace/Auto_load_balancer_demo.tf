resource "aws_lb" "phpalb1" {
  name               = "phpalb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["sg-7425e90f"]
  subnets            = ["subnet-6875e913","subnet-9f0b5ed3","subnet-79cd2912"]

  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_target_group" "phpalbtarget" {
  name     = "phpalbtarget"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-d13ac5ba"
   health_check {
    port     = 80
    protocol = "HTTP"
  }
}

resource "aws_lb_target_group_attachment" "target2" {
  target_group_arn = aws_lb_target_group.phpalbtarget.arn
  target_id        = aws_instance.ec2phpdemo2srp.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "target1" {
  target_group_arn = aws_lb_target_group.phpalbtarget.arn
  target_id        = aws_instance.ec2phpdemo1srp.id
  port             = 80
}


resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.phpalb1.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.phpalbtarget.arn
  }
}