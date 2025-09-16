#!/usr/bin/env bash

String="${*}"
#Removing trailing space
String=$(echo -e "${String}" | sed -e 's/[[:space:]]*$//')


for (( i="${#String}"; i>=0; i-- ))
do
    if [[ "${String:$i:1}" =~ /S ]]
    then
        Length=$(( ${#String} - i ))
        String="${String:0:$Length}"
    fi
done


if [[ -z "${String}" || "${String}" =~ \n\r\t ]]
then
    echo "Fine. Be that way!"

elif [[ "$String" == "${String^^}" && "${String}" =~ .+ && "${String}" =~ [a-zA-Z] ]] # Bob get YELL at HIM.
then
    if [[ "${String}" =~ \?$ ]]
    then
        echo "Calm down, I know what I'm doing!"
    else
        echo "Whoa, chill out!"
    fi    
elif [[ "${String}" =~ \?$ ]] # Bob is ask a question.
then
    echo "Sure."
else
    echo "Whatever."
fi

# elif [[ "${String}" =~ \n\r\t\0 ]]
# then
#     echo "Whatever."