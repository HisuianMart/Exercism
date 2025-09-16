#!/usr/bin/env bash

Diagram="${1}"
Student="${2}"
Students=("Alice" "Bob" "Charlie" "David" "Eve" "Fred" "Ginny" "Harriet" "Ileana" "Joseph" "Kincaid" "Larry")
Plants=''

getStudentIndex() {
local -i index
for (( i=0; i<${#Students[@]}; i++ ))
do
    if [[ "${Students[$i]}" == "${Student}" ]]
    then
        index="${i}"
    fi
done
echo "${index}"
}

StudentIndex=$(getStudentIndex)
# echo "Debug: Student Index=${StudentIndex}" #DEBUG

Start=$(( StudentIndex * 2 ))
End=$(( Start + 1 ))
# echo "Debug: Start=${Start}, End=${End}" #DEBUG

for Row in ${Diagram}
do
    # echo "Debug: Row in diagram= ${Row}" #DEBUG
    for (( i=${Start}; i<=${End}; i++ ))
    do
        case "${Row:$i:1}" in
            G)
                Plant="grass" ;;
            C)
                Plant="clover" ;;
            R)
                Plant="radishes" ;;
            V)
                Plant="violets" ;;
        esac
        if [[ -z "${Plants}" ]]
        then
            Plants="${Plant}"
        else
            Plants+=" ${Plant}"
        fi
    done
done
echo "${Plants}"
exit 0
