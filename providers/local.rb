require 'aws-sdk-dynamodb'

def dynamo
    Aws::DynamoDB::Resource.new(region: 'us-east-1', endpoint: "http://localstack:4566", credentials: Aws::Credentials.new('user', 'pass'))
end