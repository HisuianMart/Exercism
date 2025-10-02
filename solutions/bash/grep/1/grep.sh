#!/usr/bin/env bash

# parse_options() {
   # local OPTIND=1
   while getopts nlivx opt; do
      case $opt in
         n)
            line_number_flag="true"
            ;;
         l)
            file_name=true
            ;;
         i)
            insensitive=true
            ;;
         v)
            invert=true
            ;;
         x)
            entire=true
            ;;
         *)
            break
            ;;
      esac
   done
   # echo "OPTIND = ${OPTIND}"
   shift "$(($OPTIND-1))"
   Pattern="${1}"
   shift
   Files=("${@}")
# }

# parse_options


# echo "Debug: line_number=${line_number}"
# echo "Debug: file_name=${file_name}"
# echo "Debug: insensitive=${insensitive}"
# echo "Debug: invert=${invert}"
# echo "Debug: entire=${entire}"

if [[ $insensitive == "true" ]]; then
    Pattern="${Pattern,,}"
fi
if [[ $entire == "true" ]]; then
    Pattern="^${Pattern}$"
fi
if [[ "${#Files[@]}" -gt 1 ]]; then
    multi_file="true"
fi
# echo "Pattern: ${Pattern}"
# echo "Files: ${Files[@]}"

# Read the files and search $Pattern in each lines
for file in ${Files[@]}; do
   Line_Number=0
   File="${file}"
   Break="false"
    # echo "Debug: For loop"
   while IFS= read -r line || [[ -n $line ]]; do
       Result=""
      ((Line_Number++))
       # echo "Debug: Line=${Line_Number}:${line}"
      Line_Content="${line}"
      if [[ $insensitive = "true" ]]; then
         line="${line,,}"
      fi

      # Search for the $Pattern in the line
      if [[ "${line}" =~ ${Pattern} && $invert != "true" ]]; then    #&& $invert != "true"
          if [[ $file_name == "true" ]]; then #= "true" 
             Result="${File}"
             Break="true"
             # Result="1-${file}"
          elif [[ $line_number_flag == "true" && $multi_file == "true" ]]; then     # = "true" 
             Result="${File}:${Line_Number}:${Line_Content}"
             # Result="2-${Line_Number}:${Line_Content}"
          elif [[ $line_number_flag == "true" ]]; then     # = "true" 
             Result="${Line_Number}:${Line_Content}"
             # Result="2-${Line_Number}:${Line_Content}"
          elif [[ $multi_file == "true" ]]; then        #= "true" 
             Result="${File}:${Line_Content}"
             # Result="3-${file}:${Line_Content}"
          else
             Result="${Line_Content}"
             # Result="4-${Line_Content}"
          fi
      elif [[ ! "${line}" =~ ${Pattern} && $invert == "true" ]]; then
          if [[ $file_name == "true" ]]; then        #= "true" =
             Result="${File}"
             Break="true"
             # Result="5-${file}"
          elif [[ $line_number_flag == "true" && $multi_file == "true" ]]; then
             Result="${File}:${Line_Number}:${Line_Content}"
             # Result="6-${file}:${Line_Number}:${Line_Content}"
          elif [[ $line_number_flag == "true" ]]; then        #= "true" 
             Result="${Line_Number}:${Line_Content}"
             # Result="7-${Line_Number}:${Line_Content}"
          elif [[ $multi_file == "true" ]]; then        #= "true" 
             Result="${File}:${Line_Content}"
             # Result="8-${file}:${Line_Content}"
          else
             Result="${Line_Content}"
          #    # Result="9-${Line_Content}"
          fi
      fi
      # echo "DEBUG:: Line ${Line_Number} Result: ${Result}"
      if [[ -n "${Result}" ]]; then
         echo "${Result}"
         if [[ $Break == "true" ]]; then
             break;
         fi
      fi

   done < "${file}"
done
exit 0