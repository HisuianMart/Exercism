#!/usr/bin/env bash


main () {
Subtitle="${@}"
Subtitle=$( echo "${Subtitle}" | sed " s/\*/ /g" )
Subtitle=$( echo "${Subtitle}" | sed "s/\.//g; s/\!//g; s/,/ /g; s/\\\n/ /" )
Subtitle=$( echo "${Subtitle}" | sed "s/ '/ /g; s/' / /g; s/^'/ /g; s/'$//g" )
Subtitle=$( echo "${Subtitle}" | sed "s/&//g; s/@//g; s/\\$//g; s/%//g; s/\^//g; s/://g" )
Subtitle="${Subtitle,,}"

# echo "DEBUG: Subtitle: ${Subtitle}"

declare -A WordCount

for word in ${Subtitle}
do
    (( WordCount["${word}"]++ ))
done



for value in "${!WordCount[@]}"
do
    echo "${value}: ${WordCount[$value]}"
done
}

main "$@"
exit 0