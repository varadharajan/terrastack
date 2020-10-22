import os

def handler(event, context):
    return "Hello %s" % (os.environ["name"])