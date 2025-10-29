#!/usr/bin/env bash

name="${1}"
number="${2}"
suffix=""

digit=$(( ${#number} - 1 ))
case "${number:$digit:1}" in
    1)
        suffix="st";;
    2)
        suffix="nd";;
    3)
        suffix="rd"
esac

((digit--))

if [[ "${number:$digit:1}" -eq 1 && ${#number} -ne 1 ]]; then
    suffix="th"
fi
if [[ -z "${suffix}" ]]; then
    suffix="th"
fi

echo "${name}, you are the ${number}${suffix} customer we serve today. Thank you!"
exit 0