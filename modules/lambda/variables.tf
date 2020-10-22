locals {
  default_tags = {
    Name        = var.function_name
    Environment = var.env
  }
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

variable "function_code" {
  type = string
  description = "Path to lambda zip package"
}

variable "function_name" {
  type = string
  description = "Name of lambda function"
}

variable "handler" {
  type = string
  description = "Handler for the lambda function"
}

variable "runtime" {
  type = string
  description = "Runtime configuration"
}

variable "env_vars" {
  type = map
  description = "Lambda environment variables"
  default = {}
}