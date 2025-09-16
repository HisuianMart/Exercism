#!/usr/bin/env bash

RNA=$1
AminoAcids=''

getAminoAcid() {
    Codon=$1
    case "${Codon}" in
        AUG)             echo "Methionine" ;;
        UUU|UUC)         echo "Phenylalanine" ;;
        UUA|UUG)         echo "Leucine" ;;
        UCU|UCC|UCA|UCG) echo "Serine" ;;
        UAU|UAC)         echo "Tyrosine" ;;
        UGU|UGC)         echo "Cysteine" ;;
        UGG)             echo "Tryptophan" ;;
        UAA|UAG|UGA)     echo "STOP" ;;
        *)               echo "Invalid codon"
                         exit 1;;
    esac
}

### Debug ###
# echo "RNA: ${RNA}" #Debug
# echo "RNA Length: ${#RNA}" #Debug
# echo $( getAminoAcid "${RNA}" ) #Debug

# List Amino Acid
for (( i=0; i<${#RNA}; i+=3 ))
do
    Acid=$( getAminoAcid "${RNA:i:3}" )
    if [[ "${Acid}" == "Invalid codon" ]]
    then
        echo "Invalid codon"
        exit 1
    elif [[ "${Acid}" == "STOP" ]]
    then
        echo "${AminoAcids}"
        exit 0
    else
        if [[ -z "${AminoAcids}" ]]
        then
            AminoAcids="${Acid}"
        else
            AminoAcids+=" ${Acid}"
        fi
    fi
done
echo "${AminoAcids}"
exit 0