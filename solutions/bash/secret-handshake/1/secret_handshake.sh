#!/usr/bin/env bash
#
#
#

# Variable declaration
Secret="${@}"
declare -a Handshake
SecretCode=(jump "close your eyes" "double blink" wink)
HandshakeString=''

if [[ "$Secret" -lt 1 && "$Secret" -gt 31 ]]
then
    exit 1
fi

if [[ "${*}" = '0' ]]
then
    exit 0
fi

function convertIntvalToBase () # (Val Base)
{
   val=$1
   base=$2
   result=""
   while [ "$val" -ne 0 ] ; do
        result=$(( val % base ))$result #residual is next digit
        val=$(( val / base ))
   done
   echo -n $result
}


function reverseHandshake() { # Parameter: Array to inverse
    Array=("${@}")
    # echo "reverseHandshake with a Array lenght of ${#Array[@]}" #Debug
    for (( i="${#Array[@]}"; i>=0; i-- ))
    do
        if [[ -z "${HandshakeString}" ]]
        then
            HandshakeString+="${Array[$i]}"
        else
            HandshakeString+=",${Array[$i]}"
        fi
    done
    echo "${HandshakeString}"
    exit 0
}

function createHandshake() {
    Array=("${@}")
    # echo "createHandshake with a Array lenght of ${#Array[@]}" #Debug
    for (( i=0; i<"${#Array[@]}"; i++ ))
    do
        if [[ -z "${HandshakeString}" ]]
        then
            HandshakeString+="${Array[$i]}"
        else
            HandshakeString+=",${Array[$i]}"
        fi
    done
    echo "${HandshakeString}"
    exit 0
}
 

Bin=$(convertIntvalToBase "${Secret}" 2)
Bin="00000${Bin}"
Bin="${Bin: -5}"
# echo "Binary: ${Bin}"    #Debug

MaxIndex=$(( ${#Bin}-1 ))
# echo "MaxIndex = ${MaxIndex}"    #Debug
for (( index=MaxIndex; index>=0; index-- ))
do
    # echo "Digit is ${Bin:$index:1}"    #Debug
    if [[ "${Bin:$index:1}" -eq 1 && "${index}" -eq 0 && "${MaxIndex}" -eq 4 ]]
    then
        # echo "Find a Code to reverse Secret Handshake." #Debug
        reverseHandshake "${Handshake[@]}"
    elif [[ "${Bin:$index:1}" -eq 1 ]]
    then
        # echo "SecretCode for index($index) is ${SecretCode[$index-1]}" #Debug
        Handshake=("${Handshake[@]}" "${SecretCode[$index-1]}")
    fi
done
createHandshake "${Handshake[@]}"
# echo "Handshake is $Handshake"    #Debug




