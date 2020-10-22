locals {
  default_tags = {
    Name        = var.table_name
    Environment = var.env
  }
}

variable "table_name" {
  type = string
  description = "Table name"
}

variable "read_capacity" {
  description = "Read capacity"
  default = 20
}

variable "write_capacity" {
  description = "Write capacity"
  default = 20
}

variable "hash_key" {
  type = string
  description = "Hash key"
}

variable "attributes" {
  type = list(object({name = string,type = string}))
  description = "Attributes for hash / range key"
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
