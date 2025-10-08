#!/usr/bin/env bash

StartHour="${1}"
StartMin="${2}"
Delta="${3}"
Modif="${4}"
Hour="0"
Minute="0"

# Error Handling
if [[ "${#}" -gt 4 || "${#}" -lt 2 || "${#}" -eq 3 || "${Delta}" =~ [^+-] ]]; then
    echo "invalid arguments"
    exit 1
elif [[ ! "${StartHour}" =~ [0-9] || ! "${StartMin}" =~ [0-9] || "${Modif}" =~ [^0-9] ]]; then
    echo "Non numerical Hour, minutes or Delta."
    exit 1
fi

# Transfer to minutes
MinTotal=$(( 60 * StartHour ))
MinTotal=$(( MinTotal + StartMin ))

# Add or substract Delta
if [[ -n "${Modif}" ]]; then
        MinTotal=$(( MinTotal $Delta Modif ))
fi

# Calculate the number of hours, if the number of Total minutes is greater than 60.
if [[ "${MinTotal}" -ge 0 ]]; then
    while [ "${MinTotal}" -ge 60 ]; do
        MinTotal=$((MinTotal - 60))
        Hour=$((Hour + 1))
    done
    Minute="${MinTotal}"
else    # Deal with negative
    while [ "${MinTotal}" -le -60 ]; do
        MinTotal=$((MinTotal + 60))
        Hour=$((Hour - 1))
    done
    if [[ "${MinTotal}" -lt 0 ]]; then
        MinTotal=$(( 60 + MinTotal ))
        Hour=$(( 24 + Hour - 1))
    else
        Hour=$(( 24 + Hour ))
    fi
    Minute="${MinTotal}"
fi
Hour=$((Hour % 24))
if [[ "${Hour}" -lt 0 ]]; then
    Hour=$(( 24 + Hour ))
fi


# Convert to HH:MM for output
if [[ "${Hour}" -eq "24" ]]; then
    Hour"00"
fi
if [[ "${#Hour}" -eq 1 ]]; then
    Hour="0${Hour}"
fi
if [[ "${#Minute}"  -eq 1 ]]; then
    Minute="0${Minute}"
fi

echo "${Hour}:${Minute}"
exit 0