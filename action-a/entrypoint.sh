#!/bin/sh -l

env | cut -d= -f1
sh -c "echo $*"
