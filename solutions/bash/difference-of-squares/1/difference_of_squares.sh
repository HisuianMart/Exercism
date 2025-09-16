#!/usr/bin/env bash

FUNCTION=$1
NUMBER=$2

square_of_sum() {
    for (( i=${1}; i>0; i-- ))
    do
        RESULT=$(( RESULT + i ))
    done
    echo $(( RESULT**2 ))
}

sum_of_squares() {
    for (( i=${1}; i>0; i-- ))
    do
        RESULT=$(( RESULT + i**2 ))
    done
    echo "${RESULT}"
}

difference() {
    SQUARE=$(square_of_sum "${NUMBER}")
    SUM=$(sum_of_squares "${NUMBER}")
    RESULT=$(( SQUARE-SUM ))
    echo "${RESULT}"
}


"$FUNCTION" "$NUMBER"