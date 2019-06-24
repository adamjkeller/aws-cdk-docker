#!/usr/bin/env bash

# Add version here, and it will be built
latest='0.35.0'
cdk_versions=('0.33.0' '0.34.0' 'v0.35.0')

for version in "${cdk_versions[@]}";do
    echo "docker build --build-arg CDK_VERSION=$version -t adam9098/aws-cdk:"v$version""
    docker build --build-arg CDK_VERSION=$version -t adam9098/aws-cdk:"v$version" .
    docker push adam9098/aws-cdk:"v$version"
    if [[ $version == $latest ]];then
        docker push adam9098/aws-cdk:latest
    fi
done
