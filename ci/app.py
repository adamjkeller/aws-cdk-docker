#!/usr/bin/env python3

# CDK v1.7.0
from aws_cdk import (
    core,
    aws_codebuild,
    aws_dynamodb,
    aws_iam,
    aws_lambda,
    aws_logs,
    aws_ssm
)

import sh
from os import environ


class GitHubReleaseMonitor(core.Stack):

    def __init__(self, scope: core.Stack, id: str, **kwargs):
        super().__init__(scope, id, **kwargs)

        self.repo_url = 'https://api.github.com/repos/aws/aws-cdk/releases' 

        self.dynamo_table = aws_dynamodb.Table(
            self, "DynamoTable",
            table_name=self.stack_name,
            billing_mode=aws_dynamodb.BillingMode.PAY_PER_REQUEST,
            partition_key=aws_dynamodb.Attribute(name="latest_version", type=aws_dynamodb.AttributeType.STRING)
        )

        self.lambda_function = aws_lambda.Function(
            self, "GitHubReleaseMonitor",
            code=aws_lambda.AssetCode('ecee764-github-release-monitor.zip'),
            handler="lambda_function.lambda_handler",
            runtime=aws_lambda.Runtime.PYTHON_3_7,
            description="Lambda function that monitors aws-cdk repo for releases and triggers codepipeline when new release is available.",
            environment={
                "STACK_NAME": self.stack_name,
                "DYNAMO_TABLE": self.stack_name,
                "REPO_URL": self.repo_url,
                "CODEBUILD_PROJECT": 'aws-cdk-docker'
            },
            log_retention=aws_logs.RetentionDays.ONE_WEEK,
            timeout=core.Duration.seconds(10)
        )

        self.dynamo_table.grant_read_write_data(self.lambda_function)
        self.codebuild_project = aws_codebuild.Project.from_project_name(self, "CodeBuildProject", 'aws-cdk-docker')
        
        self.lambda_codebuild_iam_policy = aws_iam.PolicyStatement(
            actions=[
                'codebuild:StartBuild'
            ],
            resources=[
                self.codebuild_project.project_arn
            ]
        )

        self.lambda_function.add_to_role_policy(self.lambda_codebuild_iam_policy)
        self.ssm_param = aws_ssm.StringParameter.from_secure_string_parameter_attributes(self, "SSMParam", parameter_name='/prod/dockerhub-password',version=1)
        self.ssm_param.grant_read(self.codebuild_project)


if __name__ == '__main__':
    # https://github.com/awslabs/aws-cdk/issues/3082
    _env = {'account': environ['CDK_DEFAULT_ACCOUNT'],'region': environ['CDK_DEFAULT_REGION']}
    app = core.App()
    GitHubReleaseMonitor(app, 'aws-cdk-docker-release-monitor')
    app.synth()
