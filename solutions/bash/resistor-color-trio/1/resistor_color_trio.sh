#!/usr/bin/env bash


COLOR1=$1
COLOR2=$2
COLOR3=$3
COLORS=(black brown red orange yellow green blue violet grey white)
VALUE=''
FIND_COLOR1='false'
FIND_COLOR2='false'
FIND_COLOR3='false'

# Search for color 1
for (( index=0; index<${#COLORS[*]}; index++ ))
do
    if [[ ${COLOR1} == "${COLORS[$index]}" ]]
    then
        if [[ "${index}" -ne 0 ]]
        then
            VALUE="${index}"
            FIND_COLOR1='true'
            break;
        else
            FIND_COLOR1='true'
        fi
    fi
done
# Search for color 2
for (( index=0; index<${#COLORS[*]}; index++ ))
do
    if [[ ${COLOR2} == "${COLORS[$index]}" ]]
    then
        VALUE="${VALUE}${index}"
        FIND_COLOR2='true'
        break;
    fi
done

# Search for color 3
for (( index=0; index<${#COLORS[*]}; index++ ))
do
    if [[ ${COLOR3} == "${COLORS[$index]}" ]]
    then
        VALUE=$(( VALUE * 10**index ))
        FIND_COLOR3='true'
        break;
    fi
done
# echo "Resistor value: ${VALUE}" #Debug

if [[ "${FIND_COLOR1}" = 'false' || "${FIND_COLOR2}" = 'false' || "${FIND_COLOR3}" = 'false' ]]
then
    echo "invalid color"
    exit 1
else
    # MagnitudeFound='false'
    MultipleBase=0
    while [[ "${VALUE}" -gt 1900 ]]
    do
        VALUE=$((VALUE/1000))
        ((MultipleBase++))
    done
    case ${MultipleBase} in
        0) VALUE="${VALUE} ohms" ;;
        1) VALUE="${VALUE} kiloohms" ;;
        2) VALUE="${VALUE} megaohms" ;;
        3) VALUE="${VALUE} gigaohms" ;;
    esac
    echo "${VALUE}"
    exit 0
fi