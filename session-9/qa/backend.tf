terraform {
  backend "s3" {
    bucket = "aws-session-terraform-april"
    key    = "session-9/qa/main.tfstate"
    region = "us-east-2"
  }
}