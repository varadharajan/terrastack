terraform {
  backend "local" {
    path = "./terraform.tfstate"
  }
}

locals {
  env = "local"
}

provider "aws" {
  access_key                  = "mock_access_key"
  secret_key                  = "mock_secret_key"
  region                      = "us-east-1"
  s3_force_path_style         = true
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    dynamodb = "http://localstack:4566"
    apigateway = "http://localstack:4566"
  }
}