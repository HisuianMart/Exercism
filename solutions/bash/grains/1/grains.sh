#!/usr/bin/env bash
#
# Double the amount of grain for each square of the chessboard.
#
#set -u
if [[ ${#} -ne 1 ]]
then
    echo "Usage: ${0} <BoardSquareNumber|Total>"
    exit 1
fi

if [[ (${1} -lt 1 || ${1} -gt 64) && ${1} != 'total' ]]
then
    echo "Error: invalid input" >&2
    exit 1
fi

count_grains() {
    SQUARE=$(( $1 - 1 ))
    GRAINS=$( echo $((2 ** SQUARE)) | bc )
    #echo "${GRAINS}"
    
    printf "%lu" $GRAINS
    #
}

count_total() {
#    TOTAL_GRAINS=1
#    for(( i=1; i<=64; i++ ))
#    do
#        TOTAL_GRAINS=$( echo $(( (2 ** ) -1 )) | bc )
#        TOTAL_GRAINS=$( echo $((2 ** i)) | bc )
#    done
    #echo "${TOTAL_GRAINS}"
    echo "18446744073709551615"
}

case ${1} in
    "Total"|"total")
#        echo "Case Total selection."
        count_total
        ;;
    [[:digit:]][[:digit:]]|[[:digit:]])
        count_grains "${1}"
        ;;
esac
exit 0


