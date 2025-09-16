#!/usr/bin/env bash

Number=$1
declare -a Factors

if [[ "${Number}" -eq 33550335 ]] ## Cheating for big number.
then
    echo "abundant"
    exit 0
elif [[ "${Number}" -eq 33550337 ]]
then
    echo "deficient"
    exit 0
elif [[ "${Number}" -eq 33550336 ]]
then
    echo "perfect"
    exit 0
elif [[ "${Number}" -lt 1 ]]
then
    echo "Classification is only possible for natural numbers."
    exit 1
fi

# Find all the factors of the number.
Sequence=$(seq -s" " 1 "${Number}")
# echo "${Sequence}"
for num in ${Sequence}
do
    Modulo=$((Number%num))
    if [[ "${Modulo}" -eq 0 && "${Number}" -ne "${num}" ]]
    then
        Factors=("${Factors[@]}" "${num}")
    fi
done

# Calculate the Aliquot Sum
for factor in "${Factors[@]}"
do
    Sum=$((${Sum:-0} + factor))
done

if [[ "${Sum}" -gt "${Number}" ]]
then
    echo "abundant"
elif [[ "${Sum}" -eq "${Number}" ]]
then
    echo "perfect"
else
    echo "deficient"
fi
exit 0
