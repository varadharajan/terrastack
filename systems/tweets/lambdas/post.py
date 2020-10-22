import json
import boto3
import os

def handler(event, context):
    dynamodb = boto3.resource('dynamodb', endpoint_url=os.environ["dynamodb_endpoint"], region_name=os.environ["region"])
    tweet = {"id": event["id"], "tweet": event["tweet"]}

    table = dynamodb.Table("tweets")
    table.put_item(Item=tweet)

    return "Ok!"