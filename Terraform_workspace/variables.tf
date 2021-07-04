variable "access_key" {
  default = "AKIAY7PTQLLBYJFOTF6Q"
  }
variable "secret_key" {
  default = "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"
  }
variable "region" {
  default = "ap-south-1"
  }
variable "ami_id" {
  type = "map"

  default = {
    us-east-1    = "ami-035b3c7efe6d061d5"
    eu-west-2    = "ami-132b3c7efe6sdfdsfd"
    eu-central-1 = "ami-9787h5h6nsn"
  }
}
