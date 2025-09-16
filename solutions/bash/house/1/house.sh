#!/usr/bin/env bash


# Variable definition
FROM_VERSE=$1
TO_VERSE=$2

NP1=" the house that Jack built."
NP2=" the malt"
NP3=" the rat"
NP4=" the cat"
NP5=" the dog"
NP6=" the cow with the crumpled horn"
NP7=" the maiden all forlorn"
NP8=" the man all tattered and torn"
NP9=" the priest all shaven and shorn"
NP10=" the rooster that crowed in the morn"
NP11=" the farmer sowing his corn"
NP12=" the horse and the hound and the horn"
GENERAL_PRE="This is"
PRE1="that lay in "
PRE2="that ate"
PRE3="that killed"
PRE4="that worried"
PRE5="that tossed"
PRE6="that milked"
PRE7="that kissed"
PRE8="that married"
PRE9="that woke"
PRE10="that kept"
PRE11="that belonged to"
PRE12="This is"


if [[ $# -eq 0 ]]
then
    echo "Usage: ${0} <from_verse> <to_verse>"
    exit 1
fi

# Invalid FROM_VERSE or TO_VERSE
if [[ $FROM_VERSE -lt 1 || $FROM_VERSE -gt 12 || $TO_VERSE -lt 1 || $TO_VERSE -gt 12 ]]
then
    echo "invalid"
    exit 1
fi

# Loop to create all the verses
for (( i=$FROM_VERSE; i<=$TO_VERSE; i++ ))
do
    # Loop to create this verses
    
    for (( j=$i; j>0; j-- ))
    do
        THIS_NP="NP${j}"
        THIS_PRE="PRE${j}"
        if [[ $i -eq $j ]]
        then
            echo -n ${GENERAL_PRE}
        else
            echo -n ${!THIS_PRE}
        fi
        echo "${!THIS_NP}"
    done
    if [[ $i<=$TO_VERSE ]]
    then
        echo -en "\n"
    fi
done


