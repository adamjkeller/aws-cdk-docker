FROM python:3.7.4-alpine3.10

LABEL maintainer="adam@adamjkeller.com"
LABEL cdk_version="1.3.0"

RUN mkdir /cdk

COPY ./requirements.txt /cdk/
COPY ./downgrade.txt /cdk/
COPY ./entrypoint.sh /usr/local/bin/

WORKDIR /cdk

RUN apk -U --no-cache add \
    bash \
    git \
    nodejs=10.16.0-r0 \
    npm=10.16.0-r0 &&\
    npm i -g aws-cdk@1.3.0 &&\
    pip3 install -r requirements.txt &&\
    # To ensure on builds after new version release that we stay with pinned version
    pip3 install -r downgrade.txt &&\
    rm -rf /var/cache/apk/*

ENTRYPOINT ["entrypoint.sh"]

CMD ["--help"]
