data "archive_file" "test_lambda" {
  type        = "zip"
  source_file = "${path.module}/lambda.py"
  output_path = "/tmp/lambda.zip"
}


module "test_lambda" {
  source = "../../lambda"

  function_code = data.archive_file.test_lambda.output_path
  function_name = "test"
  handler = "lambda.handler"
  runtime = "python2.7"
  env_vars = {"name": "Varadha"}
  env = local.env
}
