#!/usr/bin/env bash

#
#
#

ARGUMENTS=$@
ARG_NUM=$#

if [[ ${ARG_NUM} -lt 1 ]]
then
    echo "Usage: ${0} <person>"
    exit 1
elif [[ ${#} -gt 1 ]]
then
    echo "Usage: ${0} <person>"
    exit 1
elif [[ -z ${ARGUMENTS} ]]
then
    echo "Hello, ${ARGUMENTS}"
    
else
    echo "Hello, ${ARGUMENTS}"
fi
