terraform {
  backend "s3" {
    bucket = "aws-session-terraform-april"
    key    = "session-10/dev/main.tfstate"
    region = "us-east-2"
  }
}