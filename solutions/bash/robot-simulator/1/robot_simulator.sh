#!/usr/bin/env bash

x="${1:-0}"
y="${2:-0}"
dir="${3:-"north"}"
Instructions="${4}"

# Error Handling
case "${dir}" in
    north) ;;
    west) ;;
    south) ;;
    east) ;;
    *)
        echo "invalid direction"; exit 1 ;;
esac

# echo "Debug: Position: ${x}/${y} facing ${dir}"
# echo "Debug: Instructions: ${Instructions}"

turn() {
    # echo "Debug: turn function with ${1} as direction."
    if [[ "${1}" == "left" ]]
    then
        case "${dir}" in
            north)
                dir="west" ;;
            west)
                dir="south" ;;
            south)
                dir="east" ;;
            east)
                dir="north" ;;
        esac
    elif [[ "${1}" == "right" ]]
    then
        case "${dir}" in
            north)
                dir="east" ;;
            west)
                dir="north" ;;
            south)
                dir="west" ;;
            east)
                dir="south" ;;
        esac
    fi
}

advance() {
    # echo "Debug: advance function with ${dir} direction."
    case "${dir}" in
        north)
            y=$((y+1)) ;;
        east)
            x=$((x+1)) ;;
        south)
            y=$((y-1)) ;;
        west)
            x=$((x-1)) ;;
        *)
            echo "invalid direction"; exit 1 ;;
    esac
}

if [[ -n "${Instructions}" ]]
then
    for (( i=0; i<${#Instructions}; i++ ))
    do
        # echo "Debug: Dealing with instruction ${Instructions:$i:1}."
        case "${Instructions:$i:1}" in
            A)
                advance ;;
            L)
                turn 'left' ;;
            R)
                turn 'right' ;;
            *)
                echo "invalid instruction"; exit 1 ;;
        esac
    done
fi

echo "${x} ${y} ${dir}"
exit 0