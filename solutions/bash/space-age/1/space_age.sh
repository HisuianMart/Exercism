#!/usr/bin/env bash

Planet="${1}"
declare -A Planets='([Mercury]="0.2408467" [Venus]="0.61519726" [Earth]="1.0" [Mars]="1.8808158" [Jupiter]="11.862615" [Saturn]="29.447498" [Uranus]="84.016846" [Neptune]="164.79132")'
AgeInSecond="${2}"

if [[ -z "${Planets[$Planet]}" ]]
then
    echo 'not a planet'
    exit 1
fi

# echo "DEBUG:: Age in Seconds: ${AgeInSecond}" #DEBUG
# echo "DEBUG:: Orbit Fraction: ${Planets[$Planet]}" #DEBUG

Year=$( echo "scale=10; ${AgeInSecond} / 31557600" | bc  )
Age=$( echo "scale=10; ${Year} / ${Planets[$Planet]}" | bc )

printf "%.2f\n" "${Age}"
exit 0
