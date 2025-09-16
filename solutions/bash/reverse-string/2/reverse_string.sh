#!/bin/bash
#
# Reverse the order of letters in words passed as arguments.
#
# MPinard 2025-06-09

# echo "Debbug: echo '$@' = $@"
# echo ''



        WORD="${*}"
        DROW=''
        for ((i=0; i<${#WORD}; i++))
        do
                DROW="${WORD:i:1}$DROW"
        done
        echo "$DROW"
exit 0