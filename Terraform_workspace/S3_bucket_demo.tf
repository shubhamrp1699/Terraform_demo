resource "aws_s3_bucket" "my_s3_bucket" {
  bucket = "ctl-devops-bucket-tf"
  acl    = "public-read"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}