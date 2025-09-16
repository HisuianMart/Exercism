#!/usr/bin/env bash


Iso="${*}"
declare -A Letters
Isogram='true'

for (( i=0; i<${#Iso}; i++ ))
do
    if [[ "${Iso:$i:1}" =~ [a-zA-Z] ]]
    then
        TempLetter="${Iso:$i:1}"
        ((Letters[${TempLetter,,}]++))
    fi
done

for Letter in ${Letters[*]}
do
    if [[ ${Letter} -gt 1 ]]
    then
        Isogram='false'
    fi
done
echo "${Isogram}"

exit 0