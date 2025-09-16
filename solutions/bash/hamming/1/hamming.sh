#!/bin/bash
#
# Test 12 Subtle bug:
# https://stackoverflow.com/questions/50209601/bug-or-feature-in-bash-test-operator-eq
#
set -e
if [[ $# -lt 2 ]]
then
    echo "Usage: $0 <string1> <string2>"
    exit 1
fi

DNAa=$1
DNAb=$2

if [[ ${#DNAa} -ne ${#DNAb} ]]
then
    echo "strands must be of equal length"
    exit 1
fi

if [[ ${#DNAa} == '' && ${#DNAb} == '' ]]
then
    exit 1
fi


HAMMING=0
if [[ ${DNAa} ]]
then
    for (( i=0; i<${#DNAa}; i++ ))
    do
        if [[ "${DNAa:$i:1}" != "${DNAb:$i:1}" ]]
        then
            HAMMING=$((HAMMING + 1))
        fi
    done
fi
echo "$HAMMING"
exit 0