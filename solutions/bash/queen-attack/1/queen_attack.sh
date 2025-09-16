#!/usr/bin/env bash

Max=7
Min=0

# Filter all arguments.
while getopts "w:b:" opt; do
  case $opt in
    w)
      WhitePosition="${OPTARG}"
      ;;
    b)
      BlackPosition="${OPTARG}"
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

# echo "White: ${WhitePosition}" #Debug
# echo "Black: ${BlackPosition}" #Debug
WhiteX=$(echo "${WhitePosition}" | awk -F',' '{print $2}')
WhiteY=$(echo "${WhitePosition}" | awk -F',' '{print $1}')
# echo "White Queen: x=${WhiteX}, y=${WhiteY}" #Debug
BlackX=$(echo "${BlackPosition}" | awk -F',' '{print $2}')
BlackY=$(echo "${BlackPosition}" | awk -F',' '{print $1}')
# echo "Black Queen: x=${BlackX}, y=${BlackY}" #Debug

if [[ "${WhiteX}" -lt 0 || "${BlackX}" -lt 0 ]]
then
    echo "column not positive" >&2
    exit 1
elif [[ "${WhiteX}" -gt 7 || "${BlackX}" -gt 7 ]]
then 
    echo "column not on board" >&2
    exit 1
elif [[ "${WhiteY}" -lt 0 || "${BlackY}" -lt 0 ]]
then
    echo "row not positive" >&2
    exit 1
elif [[ "${WhiteY}" -gt 7 || "${BlackY}" -gt 7 ]]
then
    echo "row not on board" >&2
    exit 1
elif [[ "${WhiteX}" -eq "${BlackX}" && "${WhiteY}" -eq "${BlackY}" ]]
then
    echo "same position" >&2
    exit 1
fi

if [[ "${WhiteX}" -eq "${BlackX}" && "${WhiteY}" -ne "${BlackY}" || # Same row or column
    "${WhiteX}" -ne "${BlackX}" && "${WhiteY}" -eq "${BlackY}" ]]
then
    echo 'true'
    exit 0
fi



# We move the white queen to see if it encounter the black queen. 4 directions to inspect.
WhiteXOrigin="${WhiteX}"
WhiteYOrigin="${WhiteY}"

# Top-Right direction.
while [[ "${WhiteX}" -le "${Max}" || "${WhiteY}" -le "${Max}" ]]
do
    ((WhiteX++))
    ((WhiteY++))
    if [[ "${WhiteX}" -eq "${BlackX}" && "${WhiteY}" -eq "${BlackY}" ]]
    then
        echo 'true'
        exit 0
    fi
done

# Reinitialize White Queen Original position. Top-Left direction.
WhiteX="${WhiteXOrigin}"
WhiteY="${WhiteYOrigin}"
while [[ "${WhiteX}" -ge "${Min}" || "${WhiteY}" -le "${Max}" ]]
do
    ((WhiteX--))
    ((WhiteY++))
    if [[ "${WhiteX}" -eq "${BlackX}" && "${WhiteY}" -eq "${BlackY}" ]]
    then
        echo 'true'
        exit 0
    fi
done

# Reinitialize White Queen Original position. Bottom-Right direction.
WhiteX="${WhiteXOrigin}"
WhiteY="${WhiteYOrigin}"
while [[ "${WhiteX}" -le "${Max}" || "${WhiteY}" -ge "${Min}" ]]
do
    ((WhiteX++))
    ((WhiteY--))
    if [[ "${WhiteX}" -eq "${BlackX}" && "${WhiteY}" -eq "${BlackY}" ]]
    then
        echo 'true'
        exit 0
    fi
done

# Reinitialize White Queen Original position. Bottom-Left direction.
WhiteX="${WhiteXOrigin}"
WhiteY="${WhiteYOrigin}"
while [[ "${WhiteX}" -ge "${Min}" || "${WhiteY}" -ge "${Min}" ]]
do
    ((WhiteX--))
    ((WhiteY--))
    if [[ "${WhiteX}" -eq "${BlackX}" && "${WhiteY}" -eq "${BlackY}" ]]
    then
        echo 'true'
        exit 0
    fi
done

# All other positions return false.
echo 'false'
exit 0