terraform {
  backend "s3" {
    bucket = "aws-session-terraform-april"
    key    = "main.tfstate"
    region = "us-east-2"
    workspace_key_prefix = "session-11"
  }
}

# terraform workspace list = list the workspaces
# terraform workspace new NAME = creates a new workspace and switch to that workspace
# terraform workspace select NAME = switches to certain workspace
