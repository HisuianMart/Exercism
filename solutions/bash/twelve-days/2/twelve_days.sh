#!/usr/bin/env bash

Begin=$(( ${1} - 1 ))
End=$(( ${2} - 1 ))
Days=(first second third fourth fifth sixth seventh eighth ninth tenth eleventh twelfth)
Lyrics=(" a Partridge in a Pear Tree." " two Turtle Doves," " three French Hens," " four Calling Birds," " five Gold Rings," " six Geese-a-Laying," " seven Swans-a-Swimming," " eight Maids-a-Milking," " nine Ladies Dancing," " ten Lords-a-Leaping," " eleven Pipers Piping," " twelve Drummers Drumming,")

declare -A Verses
for ((i=0;i<${#Days[@]};++i)); do
    Verses[${Days[$i]}]="${Lyrics[$i]}"
done

for (( i=$Begin; i<=$End; i++))
do
    echo -n "On the ${Days[$i]} day of Christmas my true love gave to me:"
    for (( j=$i; j>=0; j-- ))
    do
        if [[ "${j}" -eq 0 && ${Days[$i]} != ${Days[0]} ]]
        then
            echo -n " and"
        fi
        echo -n "${Verses[${Days[$j]}]}"
    done
    echo ""
done
exit 0