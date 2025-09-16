#!/usr/bin/env bash

Begin=$(( ${1} - 1 ))
End=$(( ${2} - 1 ))
Days=(first second third fourth fifth sixth seventh eighth ninth tenth eleventh twelfth)
Lyrics=(" a Partridge in a Pear Tree." " two Turtle Doves," " three French Hens," " four Calling Birds," " five Gold Rings," " six Geese-a-Laying," " seven Swans-a-Swimming," " eight Maids-a-Milking," " nine Ladies Dancing," " ten Lords-a-Leaping," " eleven Pipers Piping," " twelve Drummers Drumming,")
declare -A Verses
# =( 
# [first]=" a Partridge in a Pear Tree."
# [second]=" two Turtle Doves,"
# [third]=" three French Hens,"
# [fourth]=" four Calling Birds,"
# [fifth]=" five Gold Rings,"
# [sixth]=" six Geese-a-Laying,"
# [seventh]=" seven Swans-a-Swimming,"
# [eighth]=" eight Maids-a-Milking,"
# [ninth]=" nine Ladies Dancing,"
# [tenth]=" ten Lords-a-Leaping,"
# [eleventh]=" eleven Pipers Piping,"
# [twelfth]=" twelve Drummers Drumming,"
# )
# for Day in "${!Verses[@]}"
# do
#     echo 


for ((i=0;i<${#Days[@]};++i)); do
    Verses[${Days[$i]}]="${Lyrics[$i]}"
done

# Days=(${!Verses[@]})
# echo "DEBUG:: Days= ${Days[@]}" #Debug
# echo "DEBUG:: Sixth=${Verses[${Days[5]}]}" #Debug


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