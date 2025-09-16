#!/usr/bin/env bash


STRING="${*}"
Nuc_A=0
Nuc_C=0
Nuc_G=0
Nuc_T=0

for (( index=0; index<${#STRING}; index++ ))
do
    # echo "${STRING:index:1}" #Debug
    case ${STRING:index:1} in
        A)    Nuc_A=$((Nuc_A + 1)) ;;
        C)    Nuc_C=$((Nuc_C + 1)) ;;
        G)    Nuc_G=$((Nuc_G + 1)) ;;
        T)    Nuc_T=$((Nuc_T + 1)) ;;
        *)    echo 'Invalid nucleotide in strand'; exit 1; ;;
    esac
done

echo -e "A: ${Nuc_A}\nC: ${Nuc_C}\nG: ${Nuc_G}\nT: ${Nuc_T}"
exit 0