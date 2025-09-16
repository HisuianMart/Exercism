#!/usr/bin/env bash

Number=$1
Span=$2

# Error Handling
if [[ "${Span}" -gt "${#Number}" ]]
then
    echo "span must not exceed string length"
    exit 1
elif [[ "${Number}" =~ [[:alpha:]] || "${Span}" =~ [[:alpha:]] ]]
then
    echo "input must only contain digits"
    exit 1
elif [[ "${Span}" -lt 0 ]]
then
    echo "span must not be negative"
    exit 1
fi

LargestProduct=0
Interval=$(( ${#Number}-(${Span}-1) ))

for (( i=0; i<$Interval; i++ ))
do
    Product=0
    for (( j=0; j<$Span; j++ ))
    do
        k=$(( i+j ))
        if [[ "${j}" -eq 0 ]]
        then
            Product="${Number:$k:1}"
        elif [[ -n ${Number:$k:1} ]]
        then
            Product=$(( ${Product}*${Number:$k:1} ))
        fi
    done
    if [[ "${Product}" -gt "${LargestProduct}" ]]   
    then
        LargestProduct="${Product}"
    fi
done
echo "${LargestProduct}"
exit 0