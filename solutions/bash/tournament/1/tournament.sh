#!/usr/bin/env bash

index=0
while IFS= read -r line; do
    Matchs[$index]="${line}"
    ((index++))
done
unset IFS

header="Team                           | MP |  W |  D |  L |  P"

# declare -A Teams
declare -A MatchPlay
declare -A Win
declare -A Draw
declare -A Lose
declare -A Points

# echo "DEBUG: # Match: ${#Matchs[@]}"
# echo "DEBUG: Match content: ${Matchs[@]}"

if [[ -z "${Matchs[@]}" && ${#Matchs[@]} -eq 1 ]]; then
    echo "${header}"
    exit 0
fi

SortedWinners=()
lastTeam=""
lastPoint=0
twoWinner='false'

findTeamIndex() {
local teamToFind="${1}"
    for teamIndex in "${!SortedWinners[@]}"; do
        if [[ "${teamToFind}" == "${SortedWinners[$teamIndex]}" ]]; then
            echo "${teamIndex}"
            break;
        fi
    done        
}


# Cumulate result in differents variables.
for line in "${Matchs[@]}"; do
    team1=$(echo "${line}" | awk -F';' '{print $1}')
    team2=$(echo "${line}" | awk -F';' '{print $2}')
    result=$(echo "${line}" | awk -F';' '{print $3}')
    
    # echo "Team1: ${team1}" #DEBUG
    # echo "Team2: ${team2}" #DEBUG
    # echo "Result: ${result}" #DEBUG

    case "${result}" in
        win)
            MatchPlay["${team1}"]=$(( MatchPlay["${team1}"] + 1 ))
            MatchPlay["${team2}"]=$(( MatchPlay["${team2}"] + 1 ))
            Win["${team1}"]=$(( Win["${team1}"] + 1 ))
            Lose["${team2}"]=$(( Lose["${team2}"] + 1 ))
            Points["${team1}"]=$(( Points["${team1}"] + 3 ))
            Points["${team2}"]=$(( Points["${team2}"] + 0 ))
            ;;
        draw)
            MatchPlay["${team1}"]=$(( MatchPlay["${team1}"] + 1 ))
            MatchPlay["${team2}"]=$(( MatchPlay["${team2}"] + 1 ))
            Draw["${team1}"]=$(( Draw["${team1}"] + 1 ))
            Draw["${team2}"]=$(( Draw["${team2}"] + 1 ))
            Points["${team1}"]=$(( Points["${team1}"] + 1 ))
            Points["${team2}"]=$(( Points["${team2}"] + 1 ))            
            ;;
        loss)
            MatchPlay["${team1}"]=$(( MatchPlay["${team1}"] + 1 ))
            MatchPlay["${team2}"]=$(( MatchPlay["${team2}"] + 1 ))
            Win["${team2}"]=$(( Win["${team2}"] + 1 ))
            Lose["${team1}"]=$(( Lose["${team1}"] + 1 ))
            Points["${team2}"]=$(( Points["${team2}"] + 3 ))
            Points["${team1}"]=$(( Points["${team1}"] + 0 ))
            ;;
    esac
    # echo "Team1 points: ${Points[${team1}]}"
    # echo "Team2 points: ${Points[${team2}]}"
done


# This create a variable contaning teams name seperate by newline.
Winners=$(
    for teamName in "${!Points[@]}"; do
        echo "${Points[$teamName]}:::$teamName"
    done | sort -rn | awk -F::: '{print $2}'
  # Sort by value (first field), then print the key (second field)
)
# Need to convert this to array
# echo "DEBUG: Winners variable: ${Winners}"
mapfile -t SortedWinners <<< "${Winners}"
# echo "DEBUG: SortedWinners= ${SortedWinners[@]}"



# Check winner team order in case they have the same amount of points.
for teamName in "${SortedWinners[@]}"; do
    # if [[ "${Points[$teamName]}" -gt "${lastPoint}" ]]; then
    if [[ "${Points[$teamName]}" -eq "${lastPoint}" ]]; then
        if [[ "${teamName:0:1}" < "${lastTeam:0:1}" ]]; then
            index=$( findTeamIndex "${teamName}" )
            SortedWinners[$lastIndex]="${teamName}"   #### NEED dynamic index
            SortedWinners[$index]="${lastTeam}"
        fi
    else
        lastPoint="${Points[$teamName]}"
        lastTeam="${teamName}"
        lastIndex=$( findTeamIndex "${teamName}" )    
    fi
done


# Output the results
echo "${header}"

for winnerTeam in "${SortedWinners[@]}"; do

    # Manage space in team name display
    numSpace=$(( 31 - ${#winnerTeam} ))
    spaces="                                                                  "
    winnerDisplayName="${winnerTeam}${spaces:0:$numSpace}"

    # Manage space in team point
    Points[${winnerTeam}]="${Points[${winnerTeam}]:-0}"
    pointSpace=$(( 3 - ${#Points[${winnerTeam}]} ))
    Points[${winnerTeam}]="${spaces:0:$pointSpace}${Points[${winnerTeam}]}"
    
    echo "${winnerDisplayName}|  \
${MatchPlay["${winnerTeam}"]:-0} |  \
${Win["${winnerTeam}"]:-0} |  \
${Draw["${winnerTeam}"]:-0} |  \
${Lose["${winnerTeam}"]:-0} |\
${Points["${winnerTeam}"]}"
done
exit 0