terraform {
  backend "s3" {
    bucket = "aws-session-terraform-april"
    key    = "dev/instance.tfstate"
    region = "us-east-2"
  }
}
