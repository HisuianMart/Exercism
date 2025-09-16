#!/usr/bin/env bash


TEST=$1
TEST_COLOR=$2
COLORS=(black brown red orange yellow green blue violet grey white)

code() {
    for (( index=0; index<${#COLORS[*]}; index++ ))
    do
        if [[ ${1} == "${COLORS[$index]}" ]]
        then
            echo "${index}"
        fi
    done
}

colors() {
    for (( index=0; index<${#COLORS[@]}; index++ ))
    do
        echo "${COLORS[$index]}"
    done
}

"$TEST" "$TEST_COLOR"