#!/usr/bin/env bash

# Variable definition

Level=$1
shift
Items=$@
EnergyPoints=()

echo "Level=${Level}" #Debug

for MagicalItem in ${Items}
do
    echo "Item: ${MagicalItem}" #Debug
    for (( Item=$MagicalItem; Item<$Level; Item+=$MagicalItem ))
    do
        echo "Item Multiplier: ${Item}" #Debug
        # EnergyPoints=( ${EnergyPoints[@]} ${Item} )
        Item=$((Item+MagicalItem))
    done
done

EnergyPoints=( $( printf '%s\n' "${EnergyPoints[@]}" | sort -n | uniq ) )
TotalEnergy=0
for Point in ${EnergyPoints[*]}
do
    TotalEnergy=$((TotalEnergy+Point))
done
echo "${TotalEnergy}"
exit 0