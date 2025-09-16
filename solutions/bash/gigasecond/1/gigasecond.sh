#!/usr/bin/env bash

Time="${1}"
gigatime=1000000000

epoch=$(date -d "${Time}" +%s)
((epoch+=gigatime))
# echo "epoch: ${epoch}" #DEUBG

printf '%(%Y-%m-%dT%H:%M:%S)T\n' "$epoch"
