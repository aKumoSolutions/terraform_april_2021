terraform {
  backend "s3" {
    bucket = "aws-session-terraform-april"
    key    = "session-7/frontend.tfstate"
    region = "us-east-2"
  }
}