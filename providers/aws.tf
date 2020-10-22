terraform {
  backend "local" {
    path = "/tmp/terraform.tfstate"
  }
}

provider "aws" {
  region = "us-east-1"
}