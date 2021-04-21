resource "aws_launch_configuration" "asgtmplt" {
  name_prefix   = "foobar"
  image_id      = "ami-0bcf5425cdc1d8a85"
  instance_type = "t2.micro"
}

resource "aws_autoscaling_group" "asgphp" {
  availability_zones = ["ap-south-1a","ap-south-1b","ap-south-1c"]
  desired_capacity   = 1
  max_size           = 2
  min_size           = 1
 launch_configuration      = aws_launch_configuration.asgtmplt.name
}

/*resource "aws_autoscaling_attachment" "asg_shubham" {
  autoscaling_group_name = aws_autoscaling_group.asgphp.id
  alb_target_group_arn   = aws_alb.phpalb1.arn
}*/