module "tweets_db" {
  source = "../../modules/dynamodb"
  
  table_name = "tweets"
  hash_key = "id"
  attributes = [
    {name = "id", type = "S"}
  ]
  env = local.env
}

data "archive_file" "get_function" {
  type        = "zip"
  source_file = "${path.module}/lambdas/get.py"
  output_path = "/tmp/get-lambda.zip"
}


module "get_tweets_lambda" {
  source = "../../modules/lambda"

  function_code = data.archive_file.get_function.output_path
  function_name = "get_tweets"
  handler = "get.handler"
  runtime = "python2.7"
  env_vars = {"name": "Varadha"}
  env = local.env
}

data "archive_file" "post_function" {
  type        = "zip"
  source_file = "${path.module}/lambdas/post.py"
  output_path = "/tmp/post-lambda.zip"
}


module "post_tweets_lambda" {
  source = "../../modules/lambda"

  function_code = data.archive_file.post_function.output_path
  function_name = "post_tweets"
  handler = "post.handler"
  runtime = "python2.7"
  env_vars = {dynamodb_endpoint = local.dynamodb_endpoint, region = local.region}
  env = local.env
}
