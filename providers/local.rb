require 'aws-sdk-dynamodb'
require 'aws-sdk-lambda'

def dynamo
    Aws::DynamoDB::Resource.new(region: 'us-east-1', endpoint: "http://localstack:4566", credentials: Aws::Credentials.new('user', 'pass'))
end

def aws_lambda
    Aws::Lambda::Client.new(region: 'us-east-1', endpoint: "http://localstack:4566", credentials: Aws::Credentials.new('user', 'pass'))
end