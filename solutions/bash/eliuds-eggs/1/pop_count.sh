#!/usr/bin/env bash

Number=$1
eggs=0

toBinary() { # Not my function. https://unix.stackexchange.com/questions/223338/convert-a-value-into-a-binary-number-in-a-shell-script
    n=$(($1))
    bits=""
    sign=""
    if [ "$n" -lt 0 ]; then
       sign=- n=$((-n))
    fi
    while [ "$n" -gt 0 ]; do
       bits="$(( n&1 ))$bits";
       : $(( n >>= 1 ))
    done
    printf "%s\n" "$sign${bits:-0}"
}

Bin=$(toBinary "${Number}")

for (( i=0; i<${#Bin}; i++ ))
do
    if [[ "${Bin:i:1}" -eq 1 ]]
    then
        ((eggs+=1))
    fi
done
echo "${eggs}"
exit 0