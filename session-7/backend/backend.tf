terraform {
  backend "s3" {
    bucket = "aws-session-terraform-april"
    key    = "session-7/backend.tfstate"
    region = "us-east-2"
  }
}