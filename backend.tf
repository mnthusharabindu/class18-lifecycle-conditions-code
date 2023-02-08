terraform {
  backend "s3" {
    bucket = "devopstfstate1"
    key    = "dev-devops.tfstate"
    region = "us-east-1"
  }
}

