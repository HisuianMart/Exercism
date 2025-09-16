#!/usr/bin/env bash

ISBN="${1}"
ISBN="${ISBN//-/}"
# echo "ISBN: ${ISBN}" #DEBUG
declare -i Sum=0

if [[ ! "${#ISBN}" -eq 10 ]]
then
    echo "false"
    exit 0
fi

for (( i=0, j=10; i<10; i++, j-- ))
do
    if [[ "${ISBN:$i:1}" =~ [^0-9] && "${i}" -ne 9 ]]
    then
        echo "false"
        exit 0
    elif [[ "${ISBN:$i:1}" =~ [^0-9X] && "${i}" -eq 9 ]]
    then
        echo 'false'
        exit 0
    fi
    if [[ "${ISBN:$i:1}" == 'X' ]]
    then
        (( Sum+= j * 10 ))
    else
        (( Sum+= j * ${ISBN:$i:1} ))
    fi
    # echo "Sum: ${Sum}" #DEBUG
done
(( Sum = Sum % 11 ))
if [[ "${Sum}" -eq 0 ]]
then
    echo "true"
else
    echo "false"
fi

exit 0