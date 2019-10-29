#!/bin/sh

if [[ $1 == "bash" ]];then
    echo "entering container..."
    /bin/bash
else
    # Sourcing external env vars
    if [[ -f env_vars.sh ]]; then
        source env_vars.sh
    fi
    # Adding any additional requirements
    if [[ -f requirements-add.txt ]]; then
        pip3 install -r requirements-add.txt
    fi
    exec cdk $@
fi
