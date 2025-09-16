#!/usr/bin/env bash

Number="${1}"
declare -a Primes
Test=2

while [ "${Test}" -le "${Number}" ]
do
    Modulo=$(( Number % Test ))
    while [ "${Modulo}" -eq 0 ]
    do
        Primes+=("${Test}")
        Number=$(( Number / Test ))
        Modulo=$(( Number % Test ))
    done
    ((Test++))
done

echo "${Primes[@]}"
exit 0