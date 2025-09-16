#!/usr/bin/env bash

String=$1
Transpose=$2
LowerAlpha=(a b c d e f g h i j k l m n o p q r s t u v w x y z)
HigerAlpha=(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z)
Cypher=''

for (( i=0; i<${#String}; i++ )) # Loop through $String
do
    if [[ "${String:$i:1}" =~ [a-z]+ ]]
    then
        # echo "Dealing with letter: ${String:$i:1}" #Debug
        for (( j=0; j<=26; j++ )) # Loop through Alphabet
        do
            if [[ "${String:$i:1}" == "${LowerAlpha[$j]}" ]]
            then
                Translation=$(($j+$Transpose))
                if [[ "${Translation}" -gt 25 ]]
                then
                    Translation=$((Translation-26))
                fi
                # echo "Translation is ${Translation}" #Debug
                Cypher+="${LowerAlpha[$Translation]}"
                # echo "For ${String:$i:1} we found cypher letter ${LowerAlpha[$Translation]}." #Debug
            fi
        done
    elif [[  "${String:$i:1}" =~ [A-Z]+ ]]
    then
        # echo "Dealing with letter: ${String:$i:1}" #Debug
        for (( j=0; j<=26; j++ )) # Loop through Alphabet
        do
            if [[ "${String:$i:1}" == "${HigerAlpha[$j]}" ]]
            then
                Translation=$(($j+$Transpose))
                if [[ "${Translation}" -gt 25 ]]
                then
                    Translation=$((Translation-26))
                fi
                # echo "Translation is ${Translation}" #Debug
                Cypher+="${HigerAlpha[$Translation]}"
                # echo "For ${String:$i:1} we found cypher letter ${HigerAlpha[$Translation]}." #Debug
            fi
        done
        
    else
        Cypher+="${String:$i:1}"
    fi
done
echo "${Cypher}"
exit 0
