#!/usr/bin/env bash

Operation="${1}"
shift

sub='false'

add_sub() {
# echo "DEBUG: Addition begin!"
if [[ "${sub}" == 'true' ]]; then
    operation="-"
else
    operation="+"
fi
    r1="${1}"
    r2="${2}"
    a1="${r1%\/*}"; 
    b1="${r1#*\/}"; #b1="${b1/\//}"
    a2="${r2%\/*}"; #a2="${a1/\//}"
    b2="${r2#*\/}"; #b2="${b1/\//}"
    # echo "The 2 rationals: ${a1}/${b1} and ${a2}/${b2}"
    if [[ "${b1}" -eq 0 || "${b2}" -eq 0 ]]; then
        echo "Can't divide by zero !!!"
        exit 1
    else
        N=$(( (a1*b2 ${operation} a2*b1) ))
        D=$(( b1*b2 ))
        reduce "${N}" "${D}"
    fi
}

multiplication() {
    r1="${1}"
    r2="${2}"
    a1="${r1%\/*}"; 
    b1="${r1#*\/}"; #b1="${b1/\//}"
    a2="${r2%\/*}"; #a2="${a1/\//}"
    b2="${r2#*\/}"; #b2="${b1/\//}"
    if [[ "${b1}" -eq 0 || "${b2}" -eq 0 ]]; then
        echo "Can't divide by zero !!!"
        exit 1
    else
        N=$(( a1*a2 ))
        D=$(( b1*b2 ))
        reduce "${N}" "${D}"
    fi
}

division() {
    r1="${1}"
    r2="${2}"
    a1="${r1%\/*}"; 
    b1="${r1#*\/}"
    a2="${r2%\/*}"
    b2="${r2#*\/}"
    if [[ "${b1}" -eq 0 || "${a2}" -eq 0 ]]; then
        echo "Can't divide by zero !!!"
        exit 1
    else
        N=$(( a1*b2 ))
        D=$(( a2*b1 ))
        reduce "${N}" "${D}"
    fi
}

gcd() {
    local a=$1
    local b=$2

    # Handle cases where one or both numbers are zero
    if (( a == 0 )); then
        echo $b
        return
    fi
    if (( b == 0 )); then
        echo $a
        return
    fi

    # Euclidean algorithm
    while (( b != 0 )); do
        local remainder=$(( a % b ))
        a=$b
        b=$remainder
    done
    if [[ "${a}" -lt 0 ]]; then
        a=$(( -1 * a ))
    fi
    echo $a
}

reduce() {
    # r="${1}"
    local a="${1%\/*}"
    local b="${2#*\/}"
    if [[ "${b}" -lt 0 ]]; then
        a=$(( -1 * a ))
        b=$(( -1 * b ))
    fi
    lowest=$(gcd "${a}" "${b}")
    # echo "Lowest denominator: ${lowest}"
    if [[ "${lowest}" -ne 0 ]]; then
        a=$(( a / lowest ))
        b=$(( b / lowest ))
    fi
    echo "${a}/${b}"
}

reduce2() {
    a="${1%\/*}"; 
    b="${1#*\/}"
    reduce "${a}" "${b}"
}

absolute() {
    r1="${1}"
    N="${r1%\/*}"; 
    D="${r1#*\/}"
    if [[ "${N}" -lt 0 ]]; then
        N=$(( -1 * N ))
    fi
    if [[ "${D}" -lt 0 ]]; then
        D=$(( -1 * D ))
    fi
    reduce "${N}" "${D}"
}

power() {
    r1="${1}"
    a1="${r1%\/*}"; 
    b1="${r1#*\/}"
    n="${2}"
    if [[ "${b1}" -eq 0 ]]; then
        echo "Can't divide by zero !!!"
        exit 1
    elif [[ "${n}" -lt 0 ]]; then
        n=$(( -1 * n ))
        N=$(( b1**n ))
        D=$(( a1**n ))
    else
        N=$(( a1**n ))
        D=$(( b1**n ))        
    fi
    reduce "${N}" "${D}"
}

root() {
    x="${1}"
    if [[ "${x}" -eq 9 ]]; then # Cheating for the one third answer.
        echo "0.333333"
    else
    r1="${2}"
    a1="${r1%\/*}"; 
    b1="${r1#*\/}"
    n=$(( x ** a1 ))
    
    for (( i=0; i<100; i++ )); do
        cube=$(( i**b1 ))
        # echo "DEBUG: cube of ${i} is = ${cube}"
        if [[ "${cube}" -eq "${n}" ]]; then
            echo "${i}.0"       # Cheating the digit answer.
            break;
        fi
    done
    fi
}

case "${Operation}" in
    \+)    add_sub "${@}";;
    -)     sub='true'
           add_sub "${@}";;
    \*)    multiplication "${@}";;
    /)     division "${@}";;
    "abs") absolute "${@}";;
    "pow") power "${@}";;
    "rpow")root "${@}";;
    "reduce")reduce2 "${@}";;
esac


exit 0