#!/usr/bin/env bash


Num=$1
Steps=0

if [[ "${Num}" -lt 1 ]]
then
    echo "Error: Only positive numbers are allowed"
    exit 1
fi

while [ "${Num}" -gt 1 ]
do
    if [[ $((Num % 2)) -eq 0 ]]
    then
        Num=$((Num/2))
    else
        Num=$(( 3*Num + 1 ))
    fi
    Steps=$((Steps+1))
done
echo "${Steps}"
exit 0