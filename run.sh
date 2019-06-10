#!/usr/bin/env bash

########################
# EXAMPLE RUN COMMANDS #
########################

# cdk diff
diff() {
docker run \
    -v $(pwd):/cdk -e AWS_SESSION_TOKEN==$AWS_SESSION_TOKEN \
    -e AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION \
    -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
    -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
    -ti adam9098/aws-cdk:v0.33.0 diff
}

# cdk deploy
deploy() {
    docker run \
        -v $(pwd):/cdk \
        -e AWS_SESSION_TOKEN==$AWS_SESSION_TOKEN \
        -e AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION \
        -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
        -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
        -ti adam9098/aws-cdk:v0.33.0 deploy
}

$1
