#!/usr/bin/env bash


Num=$1

if [[ "${Num}" -eq 1 ]]
then
    echo ''
    exit 0
fi

SieveList=($(seq 0 "${Num}"))
unset "SieveList[0]"
unset "SieveList[1]"
# echo "SieveList: ${SieveList[@]}" #Debug

# Beginning with the first prime.
p=2

while [[ "${p}" -lt "${Num}" ]]
do
    # Create a sequence with the variable p
    Seq=$(seq "${p}" "${p}" "${Num}")
    # echo "Seq: ${Seq[*]}" #Debug

    # Loot through the sequence Seq and remove those number from the SieveList, minus the first one.
    for x in ${Seq}
    do
        if [[ "${x}" -ne "${p}" ]]
        then
            # echo "index of Seq ${x} give this number from SieveList: ${SieveList[${x}]}" #Debug
            toMark=${SieveList[${x}]}
            # echo "toMark: ${toMark}" #Debug
            
            if [[ "${toMark}" -eq "${x}" ]]
            then
                unset SieveList["${x}"]
            fi
        fi
    done

    # Reset the p variable
    for q in "${SieveList[@]}"
    do
        if [[ "${q}" -gt "${p}" ]]
        then
            p="${q}"
            break
        elif [[ "${q}" -eq "${SieveList[-1]}" ]]
        then
            p="${Num}"
        fi
    done
done
echo "${SieveList[@]}"
exit 0