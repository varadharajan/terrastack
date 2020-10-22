require 'aws-sdk-dynamodb'
require 'aws-sdk-apigateway'

def dynamo
    Aws::DynamoDB::Resource.new(region: 'us-east-1', endpoint: "http://localstack:4566", credentials: Aws::Credentials.new('user', 'pass'))
end

def api_gateway
    Aws::APIGateway::Client.new(region: 'us-east-1', endpoint: "http://localstack:4566", credentials: Aws::Credentials.new('user', 'pass'))
end