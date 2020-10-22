terraform {
  backend "local" {
    path = "./terraform.tfstate"
  }
}

locals {
  env = "local"
  region = "us-east-1"
  dynamodb_endpoint = "http://localstack:4566"
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
    dynamodb = local.dynamodb_endpoint
    apigateway = "http://localstack:4566"
    lambda = "http://localstack:4566"
    iam = "http://localstack:4566"
  }
}