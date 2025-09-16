#!/usr/bin/env bash

# Line12=" green bottles hanging on the wall,"
# Line3="And if one green bottle should accidentally fall,"
# Line41="There'll be "
# Line42=" green bottles hanging on the wall."
Numbers=(Ten Nine Eight Seven Six Five Four Three Two One)
Plurial="s"


# Error Handling
if [[ "${#}" -eq 0 || "${#}" -gt 2 ]]
then
    echo "2 arguments expected"
    exit 1
elif [[ "${2}" -gt "${1}" ]]
then
    echo "cannot generate more verses than bottles"
    exit 1
fi

StartVerse=$1
StartVerse=$(( 10 - StartVerse ))
EndVerse=$(( StartVerse + ${2} ))
# echo "StartVerse ${StartVerse}" #Debug 
# echo "EndVerse   ${EndVerse}" #Debug 


for (( i="${StartVerse}"; i<"${EndVerse}"; ))
do
    if [[ "${Numbers[$i],,}" == "one" ]]
    then
        Plurial=""
    fi
    echo "${Numbers[$i]} green bottle${Plurial} hanging on the wall,"
    echo "${Numbers[$i]} green bottle${Plurial} hanging on the wall,"
    i=$(( i+1 ))
    if [[ "${Numbers[$i],,}" == "one" ]]
    then
        Plurial=""
    fi
    echo "And if one green bottle should accidentally fall,"
    if [[ "${i}" -ne 10 ]]
    then
        echo "There'll be ${Numbers[$i],,} green bottle${Plurial} hanging on the wall."
    else
        echo "There'll be no green bottles hanging on the wall."
    fi
    if [[ "${i}" -lt "${EndVerse}" ]]
    then
        echo ""
    fi
done
exit 0