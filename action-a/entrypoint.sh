#!/bin/bash -l

VARS=`env | cut -d= -f1`
for var in $VARS; do
    if [ "$var" = GITHUB_TOKEN ]; then
        echo "Variable: GITHUB_TOKEN"
        continue
    fi
    value="${!var}"

    if [ -f "$value" ]; then
        echo "File: $var=$value"
        echo ====================
        cat "$value"
        echo ====================
    else
        echo "Variable: $var=$value"
    fi
done

sh -c "echo $*"
