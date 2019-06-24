#!/usr/bin/env bash

# Add version here, and it will be built
cdk_versions=('0.33.0' '0.34.0' '0.35.0')

for version in "${cdk_versions[@]}";do
    echo "docker build --build-arg CDK_VERSION=$version -t adam9098/aws-cdk:"v$version""
    docker build --build-arg CDK_VERSION=$version -t adam9098/aws-cdk:"v$version" .
    docker push adam9098/aws-cdk:"v$version"
done
