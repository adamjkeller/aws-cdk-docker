FROM python:3.7.3-alpine3.9

LABEL maintainer="adam@adamjkeller.com"

ARG CDK_VERSION 

RUN mkdir /cdk

COPY ./requirements.txt /cdk/
COPY ./entrypoint.sh /usr/local/bin/

WORKDIR /cdk

RUN apk -U --no-cache add \
    bash \
    git \
    nodejs=10.14.2-r0 \
    npm=10.14.2-r0 &&\
    npm i -g aws-cdk@${CDK_VERSION} &&\
    sed -i "s/CDK_VERSION/${CDK_VERSION}/g" requirements.txt &&\
    pip3 install -r requirements.txt

ENTRYPOINT ["entrypoint.sh"]
CMD ["cdk"]
