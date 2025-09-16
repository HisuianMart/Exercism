#!/usr/bin/env bash

STRAND=$1

# Error Handling
if [[ -z "${STRAND}" ]]
then
    exit 0
fi

RNA_STRAND=""
for (( i=0; i<${#STRAND}; i++ ))
do
    case ${STRAND:i:1} in
        A)
            RNA_STRAND+="U"
            ;;
        C)
            RNA_STRAND+="G"
            ;;
        G)
            RNA_STRAND+="C"
            ;;
        T)
            RNA_STRAND+="A"
            ;;
        *)
            echo "Invalid nucleotide detected."
            exit 1
            ;;
    esac            
done
echo "${RNA_STRAND}"
exit 0