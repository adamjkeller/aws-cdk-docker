# aws-cdk-docker

Docker images for the [aws-cdk](https://github.com/awslabs/aws-cdk). 

![Build Status](https://codebuild.us-west-1.amazonaws.com/badges?uuid=eyJlbmNyeXB0ZWREYXRhIjoiYTBSZlBlanJqQ0JvOWlzTmtEUVpDYVF6bWRJVUpleDVhalNEVUhCM2FFQWN4bHhJSytTSlY3MnNFdFNtMllISDgxVUxzRFhLU2tybU1lbWNMSmZ2YnRnPSIsIml2UGFyYW1ldGVyU3BlYyI6ImZkeGFXMUZaWUxlUlU2amEiLCJtYXRlcmlhbFNldFNlcmlhbCI6MX0%3D&branch=master)

## Supported versions

- 1.8.0
- 1.7.0
- 1.6.1
- 1.6.0
- 1.5.0
- 1.4.0
- 1.3.0
- 1.2.0
- 1.1.0
- 1.0.0
- 0.36.0

## Description

Docker images to run cdk with the following languages:
- nodejs
- typescript
- python

## Getting Started

### Dependencies

* AWS secret key, access key id, and region as environment variables to deploy the templates.
* Docker

### Executing

* Ensure you are in the root of the directory where the cdk code lives (app.py, cdk.json, etc)
* Mount the local volume on the docker run command to `/cdk` 
  * `-v $(pwd):/cdk`
* Check `./run.sh` for examples on how to run this container.
* Example command to run a cdk diff:
```
docker run \
    -v $(pwd):/cdk -e AWS_SESSION_TOKEN=$AWS_SESSION_TOKEN \
    -e AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION \
    -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
    -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
    -ti adam9098/aws-cdk:v1.6.1 diff
```

### Build your own

For the build script used, check `./build.sh` and simply update the version variable and docker repo name.
