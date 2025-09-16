#!/usr/bin/env bash

NUMBER=$1
RESULT=""
if [[ $(($NUMBER % 3)) -eq 0 ]]
then
    RESULT+="Pling"
fi
if [[ $(($NUMBER % 5)) -eq 0 ]]
then
    RESULT+="Plang"
fi
if [[ $(($NUMBER % 7)) -eq 0 ]]
then
    RESULT+="Plong"
fi
if [[ -z ${RESULT} ]]
then
    echo -n "${NUMBER}"
else
    echo -n "${RESULT}"
fi
