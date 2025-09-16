#!/usr/bin/env bash

# Variable definition
String="${1}"
Slice="${2}"

#Debug Section
# echo "${String}"
# echo "${#String}"
# echo "${Slice}"
# echo "${#Slice}"

# Error Handling
if [[ -z "${String}" ]]
then
    echo "series cannot be empty"
    exit 1
elif [[ "${Slice}" -eq 0 ]]
then
    echo "slice length cannot be zero"
    exit 1
elif [[ "${Slice}" -lt 0 ]]
then
    echo "slice length cannot be negative"
    exit 1
elif [[ "${#String}" -lt "${Slice}" ]]
then
    echo "slice length cannot be greater than series length"
    exit 1
fi

MAX_ITE=$(( ${#String} - Slice ))

for (( i=0; i<="${MAX_ITE}"; i++ ))
do
    if [[ "${i}" -eq 0 ]]
    then
        SERIES="${String:$i:$Slice}"
    else
        SERIES="${SERIES} ${String:$i:$Slice}"
    fi
done
echo "${SERIES}"
exit 0