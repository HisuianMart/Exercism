#!/usr/bin/env bash


String="${@//\*/}"
String="${String//-/' '}"
String="${String//_/}"
Acronym=

for Word in $String
do
    Word="${Word^}"
    Acronym+="${Word:0:1}"
done
echo "${Acronym}"
exit 0