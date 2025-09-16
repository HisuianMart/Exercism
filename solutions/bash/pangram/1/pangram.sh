#!/usr/bin/env bash

# Declare variables
declare -l STRING
STRING=$*
ALPHABET=(a b c d e f g h i j k l m n o p q r s t u v w x y z)

# Populate the associative array with alphabet-to-index mapping
declare -A alphabet_index_map
for i in "${!ALPHABET[@]}"; do
    alphabet_index_map["${ALPHABET[$i]}"]="$i"
done

for CARACTER in "${ALPHABET[@]}"
do
    #echo "Dealing with caracter: $CARACTER"
    for (( index=0; index<${#STRING}; index++ ))
    do
        #echo "Letter from the string: (${STRING:$index:1})"
        if [[ "${CARACTER}" = "${STRING:$index:1}" ]]
        then
            CAR_INDEX="${alphabet_index_map["${CARACTER}"]}"
            #echo "unsetting Caracter ($CARACTER) at index: $CAR_INDEX"
            unset "ALPHABET[$CAR_INDEX]"
            break
        fi
    done
done

if [[ ${#ALPHABET[@]} -gt 0 ]]
then
    echo "false"
else
    echo "true"
fi        