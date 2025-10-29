#!/usr/bin/env bash

Number="${1}"
shift
List=($@)
Find='false'
Timeout=20
start=0
stop=$(( ${#List[@]} - 1 ))
index=$(( (stop - start) / 2 ))

# Array_reindex() {
#     declare -a Temp_Array
#     in="${1}"
#     out="${2}"
#     for (( i=$in; i<=$out; i++ )); do
#         Temp_Array+=(${List[$i]})
#         # List=(${List[@]} ${List[$i]})
#     done
#     List=("${Temp_Array[@]}")
# }

while [[ $Find != 'true' && "${#List[@]}" -ne 0 && "${Timeout}" -gt 0 ]]; do
    # echo "Debug List at beginning of loop: ${List[@]}"
    # index=$(( ${#List[@]} / 2 ))
    if [[ "${index}" -eq "${lastIndex}" ]]; then
        # echo "*** Debug: index is equal to lastIndex."
        if [[ "${Number}" -gt "${List[$index]}" ]]; then
            (( index++ ))
        elif  [[ "${Number}" -lt "${List[$index]}" ]]; then
            (( index-- ))
        fi
    fi
    
    # echo "*** Debug index in loop: ${index} with Number ${List[$index]}"
    if [[ "${List[$index]}" -eq "${Number}" ]]; then
        Find='true'
        echo "${index}"
        exit 0
    elif [[ "${Number}" -lt "${List[$index]}" ]]; then
        stop=${index}
        index=$(( (stop - start) / 2 - index ))
        # Array_reindex 0 $index
        
        # echo "Debug: Number Lower than List number"
        # unset "$List[0,$index]"
        # List=("${List[@]:0:$index}")
        # Rem=$(seq -s ',' 0 $index)
        # unset "$List[$Rem]"
    elif [[ "${Number}" -gt "${List[$index]}" ]]; then
        start=${index}
        index=$(( (stop - start) / 2 + index ))

        # Array_reindex $index ${#List[@]}
        
        # echo "Debug: Number Higher than List number"
        # unset "$List[$index,${#List[@]}]"
        # List=("${List[@]:$index:0}")
        # Rem=$(seq -s ',' $index 0)
        # unset "$List[$Rem]"
    fi
    lastIndex=${index}
    ((Timeout--))
done
# echo "*** Debug List: ${List[@]}"
# echo "*** Debug Find: ${Find}"

if [[ "${Find}" != "true" ]]; then
    echo "-1"
fi
exit 0