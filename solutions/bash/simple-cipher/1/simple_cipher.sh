#!/usr/bin/env bash

alpha=({a..z})

# parse arguments and error handling
if [[ "${1}" == "key" ]]; then
    key=""
    while [ "${#key}" -le 100 ]; do
        random=$(( ${RANDOM} % 26 ))
        key="${key}${alpha[$random]}"
    done
    echo "${key}"
    exit 0
elif [[ "${1}" == "-k" ]]; then
    shift
    key="${1}"
    mode="${2}"
    # Error Handling
    if [[  "${key}" =~ [^a-z] ]]; then
        echo "invalid key" >&2
        exit 1
    fi
    if [[ "${mode}" == "encode" ]]; then
        plaintext="${3,,}"
    elif [[ "${mode}" == "decode" ]]; then
        cyphertext="${3,,}"
    fi
else
    echo "Usage: ${0} key | -k key [encode|decode] text" 2>&1
    exit
fi

getIndex() {
    local letter="${1}"
    for x in "${!alpha[@]}"; do
        if [[ "${letter}" == "${alpha[x]}" ]]; then
            # index="${!alpha[x]}"
            echo "${x}"
            break
        fi
    done
}

encode() {
    local txt="${1}"
    for (( i=0, j=0; i<"${#txt}"; i++, j++ )); do
        # index of text + index of key, minus 26 if it's exceed.
        txtIndex=$(getIndex "${txt:i:1}")
        if [[ "${j}" -ge "${#key}" ]]; then
            j=$(( j - "${#key}" ))
        fi
        # echo "DEBUG: txtIndex=${txtIndex}"
        
        keyIndex=$(getIndex "${key:j:1}")
        # echo "DEBUG: keyIndex=${keyIndex}"
        index=$(( txtIndex + keyIndex ))
        if [[ "${index}" -ge 26 ]]; then
            index=$(( index - 26 ))
        fi
        # echo "DEBUG: letter with index (${j}):${alpha[index]}"
        cypher="${cypher}${alpha[$index]}"
    done
    echo "${cypher}"
    exit 0
}

decode() {
    local cypher="${1}"
    for (( i=0, j=0; i<"${#cypher}"; i++, j++ )); do
        cypherIndex=$(getIndex "${cypher:i:1}")
        if [[ "${j}" -ge "${#key}" ]]; then
            j=$(( j - "${#key}" ))
        fi
        keyIndex=$(getIndex "${key:j:1}")
        index=$(( cypherIndex - keyIndex ))
        if [[ "${index}" -lt 0 ]]; then
            index=$(( index + 26 ))
        fi
        plaintext="${plaintext}${alpha[$index]}"
    done
    echo "${plaintext}"
    exit 0
}


case "${mode}" in
    encode)
        encode "${plaintext}";;
    decode)
        decode "${cyphertext}";;
esac
exit 0
