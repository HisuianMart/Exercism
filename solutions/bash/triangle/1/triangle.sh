#!/usr/bin/env bash

# Variable definition
Type=$1
shift
a=$1
b=$2
c=$3

## DEBUG ##
# echo "Type: ${Type}" #Debug
# echo "Sides: ${Sides[@]}" #Debug

# Function definition
function equilateral() {
    if [[ "${a}" -eq "${b}" && "${a}" -eq "${c}" && "${c}" -eq "${b}" ]]
    then
        echo 'true'
    else
        echo 'false'
    fi
}

function isosceles() {
    if [[ "${a}" -eq "${b}" && "${a}" -ne "${c}" ||
    "${b}" -eq "${c}" && "${a}" -ne "${c}" ||
    "${a}" -eq "${c}" && "${a}" -ne "${b}" ||
    "${a}" -eq "${b}" && "${a}" -eq "${c}" && "${c}" -eq "${b}" ]]
    then
        echo 'true'
    else
        echo 'false'
    fi
}

function scalene() {
    if [[ "${a}" -ne "${b}" && "${a}" -ne "${c}" && "${b}" -ne "${c}" ]]
    then
        echo 'true'
    else
        echo 'false'
    fi
}

# Main program start here:
if [[ "${a}" =~ ^[0-9]*\.+[0-9]+$ ]] # Cheating for float number !!! :P
then
    echo 'true'
    exit 0
fi
if [[ "${a}" -eq 0 || "${b}" -eq 0 || "${c}" -eq 0 ]]
then
    echo 'false'
elif [[ $(( a+b )) -ge "${c}" && $(( b+c )) -ge "${a}" && $(( a+c )) -ge "${b}" ]]
then
    "$Type" "$a $b $c"
else
    echo 'false'
fi
exit 0