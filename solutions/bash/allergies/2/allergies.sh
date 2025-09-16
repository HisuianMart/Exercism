#!/usr/bin/env bash

ID=$1
Func=$2
Type=$3

declare -a Allergies
# echo "$ID" #Debug
# Remove not listed allergens
while [ "$ID" -gt 256 ]
do
    ID=$(( ID-256 ))
done
# echo "${ID}" #Debug


# Functions definition
function show_allergie() {
    case $1 in
        128)
            echo "cats";;
        64)
            echo "pollen";;
        32)
            echo "chocolate";;
        16)
            echo "tomatoes";;
        8)
            echo "strawberries";;
        4)
            echo "shellfish";;
        2)
            echo "peanuts";;
        1)
            echo "eggs";;
    esac
}

function allergic_to() {
    Type=$1
    IsAllergic='false'
    for Allergie in ${Allergies[*]}
    do
        if [[ "${Allergie}" == "${Type}" ]]
        then
            IsAllergic='true'
        fi
    done
    echo "${IsAllergic}"
}

function list() {
    NUMBER=$1
    for (( i=7; i>=0; i--))
    do
        Modulo=$(( 2**i ))
        # echo "Score >= Modulo : ${NUMBER} >= ${Modulo}" #Debug
        if [[ "${Modulo}" -le "${NUMBER}" ]]
        then
            # echo "We find an allergie" #Debug
            if [[ $(( NUMBER - Modulo )) -ge 0 ]]
            then
                # echo "Score contain the modulo: ${Modulo}" #Debug
                # echo 'Executing show_allergie function' #Debug
                Allergie=$( show_allergie "$(( $Modulo ))" )
                # echo "Allergie = ${Allergie}" #Debug
                if [[ -z "${Allergies[@]}" ]]
                then
                    Allergies=("${Allergie}")
                else
                    Allergies=("${Allergie}" "${Allergies[@]}")
                fi
            fi
            NUMBER=$(( NUMBER-Modulo ))
        fi

        # echo "Number (Allergie Score): ${NUMBER}" #Debug
    done
    # echo 'Finishing List function' #Debug
}
# Create a list of all allergies
list "$ID"

case "$Func"
in
    list)
        echo "${Allergies[*]}";;
    allergic_to)
        allergic_to "$Type";;
esac
exit 0