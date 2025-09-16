#!/usr/bin/env bash


# Length of each line should be 2n+1, where n is 0 if A, 1 if B...
# 
#
#

Letters=({A..Z})
Letter=$1

searchIndex() {
SearchLetter=$1
for index in ${!Letters[@]}
do
    if [[ "${Letters[$index]}" == "${SearchLetter}" ]]
    then
        echo "${index}"
    fi
done
}

n=$(searchIndex ${Letter})
# echo "Index of ${Letter} is ${n}" #Debug

# Create a list of token of {0..n} {(n-1)..0}
RowList=$(seq -s' ' 0 $n)
RowList+=" $(seq -s' ' $(($n-1)) -1 0)"
# echo "Token List: ${RowList}" #Debug

nMinus=$(( -1 * n ))

#Loop through Rows, i define the Letter to print on row ${Letters[${i}]} or ${Letters[${i#-}]} if negative i index.
for i in ${RowList}
do
    for (( j=${nMinus}; j<=${n}; j++ )) #Loop through Columns from -n to n
    do
        # echo "j:${j}"
        ColumnAbs="${j#-}"
        # echo "Column Absolute:${ColumnAbs}"
        if [[ "${i}" -eq "${ColumnAbs}" ]]
        then
            if [[ "${j}" == "${n}" ]]
            then
                echo "${Letters[${i}]}"
            else
                echo -n "${Letters[${i}]}"
            fi
        else
            if [[ "${j}" == "${n}" ]]
            then
                echo " "
            else
                echo -n " "
            fi
        fi
    done
done