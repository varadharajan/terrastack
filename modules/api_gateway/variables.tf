locals {
  default_tags = {
    Name        = var.api_gateway_name
    Environment = var.env
  }
}

variable "api_gateway_name" {
  type = string
  description = "Name of API gateway"
}

variable "tags" {
  type = map
  description = "Tags (optional)"
  default = {}
}

variable "env" {
  type = string
  description = "Deployment environment"
}