#!/usr/bin/env bash


Word=$*
if [[ -z "${Word}" ]]
then
    echo "0"
fi

for (( i=0; i<${#Word}; i++ ))
do
    Word=${Word,,}
    case ${Word:i:1} in
        a|e|i|o|u|l|n|r|s|t)
            Score=$(( Score + 1 )) ;;
        d|g)
            Score=$(( Score + 2 )) ;;
        b|c|m|p)
            Score=$(( Score + 3 )) ;;
        f|h|v|w|y)
            Score=$(( Score + 4 )) ;;
        k)
            Score=$(( Score + 5 )) ;;
        j|x)
            Score=$(( Score + 8 )) ;;
        q|z)
            Score=$(( Score + 10 )) ;;
        "")
            Score=$(( Score + 0 )) ;;
    esac   
done
echo "${Score}"
exit 0