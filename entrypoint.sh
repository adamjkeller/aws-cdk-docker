#!/bin/sh

if [[ $1 == "bash" ]];then
    echo "entering container..."
    /bin/bash
else
    exec cdk $@
fi
