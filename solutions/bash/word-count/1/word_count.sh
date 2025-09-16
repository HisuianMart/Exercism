#!/usr/bin/env bash


main () {

Subtitle="${@}"
# echo "DEBUG: Subtitle: ${Subtitle}"
Subtitle=$( echo "${Subtitle}" | sed " s/\*/ /g" )
# echo "DEBUG: Subtitle: ${Subtitle}"
Subtitle=$( echo "${Subtitle}" | sed "s/\.//g; s/\!//g; s/,/ /g; s/\\\n/ /" )
Subtitle=$( echo "${Subtitle}" | sed "s/ '/ /g; s/' / /g; s/^'/ /g; s/'$//g" )
Subtitle=$( echo "${Subtitle}" | sed "s/&//g; s/@//g; s/\\$//g; s/%//g; s/\^//g; s/://g" )

# Subtitle="${Subtitle/[.!:;,]+//}"
# Subtitle="${Subtitle/\\n/}"
Subtitle="${Subtitle,,}"

# echo "DEBUG: Subtitle: ${Subtitle}"

declare -A WordCount

for word in ${Subtitle}
do
    # echo "Processing word: ${word}"
    (( WordCount["${word}"]++ ))    # WordCount["${word}"]=
    # echo "WordCount['${word}']= ${WordCount[${word}]}"
done



for value in "${!WordCount[@]}"
do
    # echo ''
    echo "${value}: ${WordCount[$value]}"
done
}
# call main with all of the positional arguments
main "$@"
exit 0