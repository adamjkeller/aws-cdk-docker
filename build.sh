#!/usr/bin/env bash

version="1.6.1"
latest="True"

if [[ $latest == "True" ]];then
    tags="-t adam9098/aws-cdk:"v$version" -t adam9098/aws-cdk:latest"
else
    tags="-t adam9098/aws-cdk:"v$version""
fi

echo "docker build --no-cache $tags"
docker build --no-cache $tags .

# Push to dockerhub
docker push adam9098/aws-cdk:"v$version"

if [[ $version == $latest ]];then
    # Push latest tag to dockerhub
    docker push adam9098/aws-cdk:latest
fi
