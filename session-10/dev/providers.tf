provider "aws" {
  region = "us-west-2"
}
provider "aws" {
  alias = "virginia"
  region = "us-east-1"
}

terraform {
  required_version = "~>0.14.0" # what is difference between "~>0.14.0" and "0.14.0" Lazy Constraint
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.24.0"
    }
  }
}