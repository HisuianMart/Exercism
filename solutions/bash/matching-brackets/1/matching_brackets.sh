#!/usr/bin/env bash

String="${@}"

Bracketeer=''

for (( i=0; i<"${#String}"; i++ ))
do
    case ${String:i:1} in
        "[")
            Bracketeer="${Bracketeer}[" ;;
        "]")
            if [[ "${Bracketeer: -1}" != "[" ]]
            then
                echo 'false'
                exit 0
            else
                Bracketeer="${Bracketeer%?}"
            fi ;;
        "{")
            Bracketeer="${Bracketeer}{" ;;
        "}")
            if [[ "${Bracketeer: -1}" != "{" ]]
            then
                echo 'false'
                exit 0
            else
                Bracketeer="${Bracketeer%?}"
            fi ;;
        "(")
            Bracketeer="${Bracketeer}(" ;;
        ")")
            if [[ "${Bracketeer: -1}" != "(" ]]
            then
                echo 'false'
                exit 0
            else
                Bracketeer="${Bracketeer%?}"
            fi ;;
    esac 
done

if [[ -z "${Bracketeer}" ]]
then
    echo 'true'
else
    echo 'false'
fi
exit 0




   ### First Try ### Failed test 8, 10 and 20! :/

# Bracket=0
# Brace=0
# Parentheses=0
# LastOpen=''

# for (( i=0; i<"${#String}"; i++ ))
# do
#     case ${String:i:1} in
#         "[")
#             Bracket=$(( Bracket + 1))
#             LastOpen="Bracket" ;;
#         "]")
#             if [[ "${LastOpen}" != "Bracket" ]]
#             then
#                 echo 'false'
#                 exit 0
#             else
#                 Bracket=$(( Bracket - 1))
#             fi ;;
#         "{")
#             Brace=$(( Brace + 1)) 
#             LastOpen="Brace" ;;
#         "}")
#             if [[ "${LastOpen}" != "Brace" ]]
#             then
#                 echo 'false'
#                 exit 0
#             else
#                 Brace=$(( Brace - 1)) 
#             fi ;;
#         "(")
#             Parentheses=$(( Parentheses + 1 ))
#             LastOpen="Parentheses" ;;
#         ")")
#             if [[ "${LastOpen}" != "Parentheses" ]]
#             then
#                 echo 'false'
#                 exit 0
#             else
#                 Parentheses=$(( Parentheses - 1 ))
#             fi ;;
#     esac
    
#     if [[ "${Bracket}" -lt 0 || "${Brace}" -lt 0 || "${Parentheses}" -lt 0 ]]
#     then
#         echo 'false'
#         exit 0
#     fi
# done

# if [[ "${Bracket}" -eq 0 && "${Brace}" -eq 0 && "${Parentheses}" -eq 0 ]]
# then
#     echo 'true'
# else
#     echo 'false'
# fi
# exit 0

            