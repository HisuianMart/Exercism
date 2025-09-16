#!/usr/bin/env bash

A=$1
B=$2

usage() {
    echo "Usage: ${0} <x_coord> <y_coord>"
    exit 1
}

# Error Handling
if [[ -z "${A}" || -z "${B}" || "${A}" =~ [^0-9\.-] || "${B}" =~ [^0-9\.-] ]]
then
    usage
fi

# To comply with float point number, we multiply everything by 10.
A=$(echo "${A} * 10" | bc)
B=$(echo "${B} * 10" | bc)
Point=0

Hyp=$( echo "sqrt( ${A}^2 + ${B}^2 )" | bc -l )
Hyp=$(echo "scale=2;${Hyp}*10" | bc )
# echo "Hyphothenuse= ${Hyp}" #Debug 
Hyp=$(echo "scale=0;${Hyp}/1" | bc )
# echo "Hyphothenuse= ${Hyp}" #Debug 

if [[ "${Hyp}" -ge 0 && "${Hyp}" -le 100 ]]
then
    Point=$((${Point}+10))
elif [[ "${Hyp}" -ge 100 && "${Hyp}" -le 500 ]]
then
    Point=$((${Point}+5))
elif [[ "${Hyp}" -gt 500 && "${Hyp}" -le 1000 ]] 
then
    Point=$((${Point}+1))
fi
echo "${Point}"
exit 0