#!/usr/bin/env bash

Number="${*}"
Valid_Number='true'

# Remove all none 
Number="${Number//[^[:alnum:]]/}"
Number_Length="${#Number}"
#Remove Alpha caracters and compare length
Number_Alpha=${Number//[^0-9]/}

if [[ "${Number_Length}" != "${#Number_Alpha}" ]] # If number has caracter it's invalid.
then
    Valid_Number='false'
fi

Number="${Number//[^0-9]/}"    # Remove everything other than digit.

if [[ "${#Number}" -gt 11 || "${#Number}" -lt 10 ]]    # Greater dans 11, Invalid.
then
    Valid_Number='false'
    # echo "Debug: Greater than 11 or less than 10."
elif [[ "${#Number}" -eq 11 && "${Number:0:1}" -ne 1 ]]
then
    Valid_Number='false'
    # echo "Debug: Length of 11, but Country Code != 1"
elif [[ "${#Number}" -eq 11 && "${Number:0:1}" -eq 1 ]]
then
    Number=${Number:1:10}
    # echo "Debug: Length of 11 and Country Code = 1"
    # echo "10 digit number: ${Number}" #Debug
    Valid_Number='true'
    if [[ ! "${Number:0:1}" =~ ^[2-9] || ! "${Number:3:1}" =~ ^[2-9] ]]
    then
        # echo "Debug: Lenght of 11 with 1 country code, but N != [2-9]"
        # echo "N = ${Number:0:1},${Number:3:1}" #Debug
        Valid_Number='false'
    fi
elif [[ ! "${Number:0:1}" =~ ^[2-9] || ! "${Number:3:1}" =~ ^[2-9]  ]]
then
    Valid_Number='false'   
    # echo "Debug: Lenght of 10, but N != [2-9]"
    # echo "N = ${Number:0:1},${Number:3:1}"
fi

# Check if the rest of the digit are valid.
for (( i=0; i<${#Number}; i++ ))
do
    if [[ ! "${Number:i:1}" =~ ^[0-9]$ ]]
    then
        # echo "For loop, Number:i = ${Number:i:1}"
        Valid_Number='false'
    fi
done

# echo "Number valid? ${Valid_Number}" #Debug

if [[ "${Valid_Number}" == 'true' ]]
then
    echo "${Number}"
else
    echo "Invalid number.  [1]NXX-NXX-XXXX N=2-9, X=0-9"
    exit 1
fi
exit 0
exit 0