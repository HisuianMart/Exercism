#!/usr/bin/env bash

Number="${1// /}"
# echo "DEBUG: Number=${Number}" #Debug
Sum=0

# Error handling
if [[ "${#Number}" -le 1 || "${Number}" =~ [^0-9] ]]
then
    echo "false"
    exit 0
fi

for (( i="${#Number}"-1, j=0; i>=0; i--, j++ ))
do
    # echo "Debug: Number:i=${Number:i:1}"
    if [[ $((j % 2)) -eq 0 ]] ## If j is even we add the number to the sum
    then
        Sum=$(($Sum + ${Number:i:1}))
    else                ## If j is odd, we double the number and check if is greater than 9.
        if [[ $(( ${Number:i:1} * 2 )) -gt 9 ]]
        then
            Sum=$(( $Sum + ${Number:i:1}*2 - 9 ))
            # echo "Debug2: Sum=${Sum}"
        else
            Sum=$(( $Sum + (${Number:i:1}*2) ))
        fi
    fi
    # echo "Debug1: Sum=${Sum}"
done

if [[ $((Sum % 10)) -eq 0 ]]
then
    echo "true"
else
    echo "false"
fi

exit 0

# "1 2345 6789 1234 5678 9012"