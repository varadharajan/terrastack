import json
import boto3
import os

def handler(event, context):
    dynamodb = boto3.resource('dynamodb', endpoint_url=os.environ["dynamodb_endpoint"], region_name=os.environ["region"])
    table = dynamodb.Table("tweets")

    tweets = table.scan()['Items']
    return json.dumps(tweets)