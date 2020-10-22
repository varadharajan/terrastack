resource "aws_iam_role" "function" {
  name = "iam_for_${var.function_name}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "function" {
  filename      = var.function_code
  function_name = var.function_name
  role          = aws_iam_role.function.arn
  handler       = var.handler

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  source_code_hash = filebase64sha256(var.function_code)

  runtime = var.runtime

  environment {
    variables = var.env_vars
  }

  tags = merge(local.default_tags, var.tags)
}