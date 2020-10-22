module "test_api_gw" {
  source = "../../api_gateway"
  
  api_gateway_name = "test_api_gw"  
  env = local.env
}

output "id" {
  value = module.test_api_gw.id
}

output "root_resource_id" {
  value = module.test_api_gw.root_resource_id
}
