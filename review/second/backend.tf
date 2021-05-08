terraform {
  backend "s3" {
    bucket = "aws-session-terraform-april"
    key    = "review/second/terraform.tfstate"
    region = "us-east-2"
  }
}