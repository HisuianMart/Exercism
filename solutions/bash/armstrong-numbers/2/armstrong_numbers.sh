#!/usr/bin/env bash
#
# Enter a number to determine if it is a Armstrong number.
#
#
if [[ $# -lt 1 ]]
then
    echo "Usage: $0 <numberToTest>"
    exit 1
fi

NUMBER=$1
SUM=''
EXPONENT=${#NUMBER}


for i in $(seq 0 $((${#NUMBER}-1)) )
do
    DIGIT=${NUMBER:i:1}
    SUM=$(( SUM + (DIGIT ** EXPONENT) ))
done

if [[ "${SUM}" == "${NUMBER}" ]]
then
    echo "true"
else
    echo "false"
fi
exit 0