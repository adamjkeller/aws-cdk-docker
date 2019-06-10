# aws-cdk-docker

Docker images for the [aws-cdk](https://github.com/awslabs/aws-cdk). For now, it's one image which includes node 10.14 and python 3.7.3.

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
    -ti adam9098/aws-cdk:v0.33.0 diff
```

### Build your own

* Pass the cdk version you want as a build argument to the docker build command.
* Example:
```
docker build --build-arg CDK_VERSION=0.34.0 -t adam9098/aws-cdk:v0.34.0 .
```
* For the build script used, check `./build.sh`