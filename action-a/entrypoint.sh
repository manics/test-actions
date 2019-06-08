#!/bin/bash -l

VARS=`env | cut -d= -f1`
for var in $VARS; do
    if [ -f "$var" ]; then
        echo "File: $var"
        echo ====================
        cat $var
        echo ====================
    elif [ "$var" = GITHUB_TOKEN ]; then
        echo "Variable: GITHUB_TOKEN"
    else
        echo "Variable: $var=${!var}"
    fi
done

sh -c "echo $*"
