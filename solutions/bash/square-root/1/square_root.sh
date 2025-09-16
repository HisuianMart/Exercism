#!/usr/bin/env bash

Target=$1

if [[ "${Target}" -lt 0 ]]
then
    echo "Not negative number please."
    exit 1
fi

Guess=$(( Target / 4 ))
if [[ "${Guess}" -le 0 ]]
then
    Guess=1
fi
Diff=1

while [[ "${Diff}" -gt 0 ]]
do
    OldGuess="${Guess}"
    Guess=$(( ( Guess + Target/Guess ) /2 ))
    # echo "New guess=${Guess}" >&2 #Debug
    if [[ "${Guess}" -gt "${OldGuess}" ]]
    then
        Diff=$(( Guess-OldGuess ))
    else
        Diff=$(( OldGuess-Guess ))
    fi
    # echo "Diffence between last two guess: ${Diff}" >&2 #Debug
done


echo "${Guess}"
exit 0