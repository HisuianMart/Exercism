#!/usr/bin/env bash

Mode="${1}"
String="${2,,}"
String="${String// /}"
declare -A Alpha
Alpha=(["a"]="z" ["b"]="y" ["c"]="x" ["d"]="w" ["e"]="v" ["f"]="u" ["g"]="t" ["h"]="s" ["i"]="r" ["j"]="q" ["k"]="p" ["l"]="o" ["m"]="n" ["n"]="m" ["o"]="l" ["p"]="k" ["q"]="j" ["r"]="i" ["s"]="h" ["t"]="g" ["u"]="f" ["v"]="e" ["w"]="d" ["x"]="c" ["y"]="b" ["z"]="a")
Atbash=

for (( i=0, j=0; i<${#String}; i++ ))
do
    if [[ "${String:i:1}" =~ [^a-z] && "${String:i:1}" =~ [^0-9] ]] 
    then    # ponctuation -> Continue
        continue
    fi
       
    if [[ j%5 -eq 0 && j -ne 0 && "${Mode}" == "encode" ]]
    then
        Atbash+=" "
    fi
        
    if [[ "${String:i:1}" =~ [0-9] ]]
    then
        Atbash+="${String:i:1}"
    else
        Atbash+="${Alpha[${String:i:1}]}"
    fi
    (( j++ ))
done
echo "${Atbash}"

exit 0