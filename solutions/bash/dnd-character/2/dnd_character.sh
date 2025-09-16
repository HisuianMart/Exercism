#!/usr/bin/env bash


Func=$1
Score=$2

rollDices() {
    Stat=$(( $RANDOM % 16 + 3 ))
    echo "${Stat}"
}

modifier() {
    Score=$1
    Modifier=$(( Score-10 ))
    if [[ "${Modifier}" -lt 0 ]]
    then
        ((Modifier--))
    fi
    Modifier=$(( Modifier/2 ))
    echo "${Modifier}"
}

generate() {
    Stat=$(rollDices)
    echo "strength ${Stat}"
    Stat=$(rollDices)
    echo "dexterity ${Stat}"
    Stat=$(rollDices)
    Constitution="${Stat}"
    echo "constitution ${Stat}"
    Stat=$(rollDices)
    echo "intelligence ${Stat}"
    Stat=$(rollDices)
    echo "wisdom ${Stat}"
    Stat=$(rollDices)
    echo "charisma ${Stat}"
    Hits=$(modifier "${Constitution}")
    Hits=$((10+Hits))
    echo "hitpoints ${Hits}"
}

"${Func}" "${Score}"
exit 0