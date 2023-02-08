terraform {
  required_version = "<= 1.3.16" #Forcing which version of Terraform needs to be used
  required_providers {
    aws = {
      version = "<= 5.0.0" #Forcing which version of plugin needs to be used.
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.aws_region
}
