#!/usr/bin/env bash


func="${1}"
data="${2}"
RLE=
last=""

encode() {
End=$(( ${#data} - 1 ))

    for (( i=0; i<"${#data}"; i++ ))
    do
        if [[ "${last}" = "${data:$i:1}" ]]    
        then
            (( count++ ))
            if [[ "${i}" -eq ${End} ]]
            then
                RLE+="${count}${last}"
            fi           
        elif [[ "${i}" -eq ${End} ]]
        then
            if [[ "${count}" -eq 1 ]]
            then
                RLE+="${last}"
            else
                RLE+="${count}${last}"
            fi
            RLE+="${data:$i:1}"
        elif [[ "${i}" -ne 0 ]]
        then              
            if [[ "${count}" -le 1 ]]
            then
                RLE+="${last}"
            else
                RLE+="${count}${last}"
            fi
            last="${data:$i:1}"
            count=1
        else
            last="${data:$i:1}"
            count=1           
        fi
    done
}

decode() {
count=""
for (( i=0; i<"${#data}"; i++ ))
do
    if [[ "${data:$i:1}" =~ [0-9] ]]
    then
        count+="${data:$i:1}"
    else
        if [[ "${count}" != "" ]]
        then
            for (( j=0; j<${count}; j++ ))
            do
                RLE+="${data:$i:1}"
            done    
        else
            RLE+="${data:$i:1}"
        fi
        count=""
    fi
done
}

"${func}" "${data}"
echo "${RLE}"
exit 0