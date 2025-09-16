#!/usr/bin/env bash

Nouns=("${@}")

for (( i=0; i<${#Nouns[@]}; )); do
    if [[ "${i}" -lt $((${#Nouns[@]} - 1)) ]]; then
        echo -n "For want of a ${Nouns[$i]}"
        ((i++))
        echo " the ${Nouns[$i]} was lost."
    else
        echo "And all for the want of a ${Nouns}."
        ((i++))
    fi
done
exit 0