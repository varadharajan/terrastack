resource "aws_api_gateway_rest_api" "api_gw" {
  name = var.api_gateway_name

  endpoint_configuration {
    types = ["REGIONAL"]
  }

  tags = merge(local.default_tags, var.tags)
}