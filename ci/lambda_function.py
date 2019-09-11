#!/usr/bin/env python3

import json
import boto3
import requests
from os import getenv

def codebuild(latest_version):
    cb = boto3.client('codebuild')
    response = cb.start_build(
        projectName=getenv('CODEBUILD_PROJECT'),
        environmentVariablesOverride=[
            {
                'name': 'cdk_version',
                'value': latest_version,
                'type': 'PLAINTEXT'
            },
            {
                'name': 'dockerhub_password',
                'value': '/prod/dockerhub-password',
                'type': 'PARAMETER_STORE'
            },
        ],
    )
    print(response)

def dynamo(latest_release):
    dynamodb = boto3.resource("dynamodb", region_name=getenv('AWS_REGION'))
    table = dynamodb.Table(getenv('DYNAMO_TABLE'))
    response = table.get_item(
        Key={'latest_version': latest_release}
    )
    
    try:
        print("Version {} exists, no need to create!".format(response['Item']['latest_version']))
    except KeyError:
        print("Item {} does not exist. Triggering Build.".format(latest_release))
        put = table.put_item(
                  Item={'latest_version': latest_release}
              )
        print(put)
        return True

def lambda_handler(event, context):
    r = requests.get(getenv('REPO_URL'))
    j = json.loads(r.text)
    latest_release = max([z for x in j for y,z in x.items() if y == 'tag_name'])
    results = dynamo(latest_release)
    if results:
        codebuild(latest_release)