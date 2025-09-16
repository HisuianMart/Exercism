#!/usr/bin/env bash

YEAR=$1

if [[ -z ${YEAR} || ${#} > 1 || ${@} =~ [^0-9] || ${@} =~ \. ]]
then
    echo "Usage: ${0} <year>"
    exit 1
fi

if [[ $(( ${YEAR}%4 )) -eq 0 ]]
then
    if [[ $(( ${YEAR}%400 )) -eq 0 ]]
    then
        if [[ $(( ${YEAR}%100 )) -ne 0 ]]
        then
            echo 'false'
        else
            echo 'true'
        fi
    elif [[ $(( ${YEAR}%100 )) -ne 0 ]]
    then
        echo 'true'
    else
        echo 'false'
    fi
else
    echo 'false'
fi
exit 0