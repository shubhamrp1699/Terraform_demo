

resource "aws_instance" "ec2_terraform" {
  ami           = var.ami_id
  instance_type = var.instance_type

  root_block_device {
    volume_type = var.volume_type
    volume_size = var.volume_size
    encrypted   = "true"
  }
  tags                   = var.tag_values
  key_name               = var.ec2_key_name
  subnet_id              = var.subnet_name
  vpc_security_group_ids = [aws_security_group.allow_http_mod_demo.id]

  user_data = <<-EOF
                #!/bin/bash
                yum update -y
                yum install -y httpd
                systemctl start httpd.service
                systemctl enable httpd.service
                echo "Welcome to EC2 advance Demo Terraform Demo!!!, I am $(hostname -f) hosted by Terraform" > /var/www/html/index.html
                EOF
}


