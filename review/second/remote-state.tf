data "terraform_remote_state" "s3" {
  backend = "s3"
  config = {
    bucket = "aws-session-terraform-april"
    key    = "review/terraform.tfstate"
    region = "us-east-2"
  }
}