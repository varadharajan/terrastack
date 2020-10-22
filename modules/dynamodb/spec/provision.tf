module "test_table" {
  source = "../../dynamodb"
  
  table_name = "test"
  hash_key = "id"
  attributes = [
    {name = "id", type = "S"}
  ]
  env = local.env
}