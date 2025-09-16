#!/usr/bin/env bash

COLOR1=$1
COLOR2=$2
COLORS=(black brown red orange yellow green blue violet grey white)
VALUE=''

FIND_COLOR1='false'
FIND_COLOR2='false'

# Search for color 1
for (( index=0; index<${#COLORS[*]}; index++ ))
do
    if [[ ${COLOR1} == "${COLORS[$index]}" ]]
    then
        if [[ "${index}" -ne 0 ]]
        then
            VALUE="${index}"
            FIND_COLOR1='true'
            break;
        else
            FIND_COLOR1='true'
        fi
    fi
done

# Search for color 2
for (( index=0; index<${#COLORS[*]}; index++ ))
do
    if [[ ${COLOR2} == "${COLORS[$index]}" ]]
    then
        VALUE="${VALUE}${index}"
        FIND_COLOR2='true'
        break;
    fi
done

if [[ "${FIND_COLOR1}" = 'false' || "${FIND_COLOR2}" = 'false' ]]
then
    echo "invalid color"
    exit 1
else
    echo "${VALUE}"
    exit 0
fi