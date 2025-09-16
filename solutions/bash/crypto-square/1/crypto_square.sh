#!/usr/bin/env bash
# Crypto Square
# 
Text="${1,,}"
Text="${Text// /}"
Text="${Text//[^[:alnum:]]/}"
col=1
row=1
Out=""

if [[ "${#Text}" -eq 0 ]]
then
    echo "${Out}"
    exit 0
fi

# Crypto Square
while [[ col*row -lt "${#Text}" ]]
do
    if [[ col -le row ]]
    then
        (( col++ ))
    else
        (( row++ ))
    fi
done

# echo "Debug: Square is ${col}x${row}"

for (( c=0; c<col; c++ ))
do
    for (( r=0; r<row; r++ ))
    do
        if [[ r%col -eq 0 && c -ne 0 ]]
        then
            Out+=" "
        fi
        
        if [[ ! -n "${Text:(r*col)+c:1}" ]]
        then
            Out+=" "
        else
            Out+="${Text:(r*col)+c:1}"
        fi
    done
done

echo "${Out}"
exit 0