terraform {
  backend "s3" {
    bucket = "aws-session-terraform-april"
    key    = "qa/instance.tfstate"
    region = "us-east-2"
  }
}
