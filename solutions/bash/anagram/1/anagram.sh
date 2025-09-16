#!/usr/bin/env bash


Target=${1}
Candidates=${2}
Result=''

#Debug
# echo "Target:    ${Target}"
# echo "Candidates: ${Candidates}"

# Need to redo all this part -> Or find a solution to same letter twice in a candidate give erronus NumberOfIdenticalLetters --> Solved using TargetComplete and CandidateComplete in which I replace each letter found by underscore.
for Candidate in ${Candidates}
do
    # echo "-- Candidate: ${Candidate}" #Debug
    NumberOfIdenticalLetters=0
    TargetComplete="${Target,,}"
    CandidateComplete="${Candidate,,}"
    if [[ "${#Target}" -ne "${#Candidate}" ]]
    then
        # echo "${Candidate} candidate length not the same as target." #Debug
        continue
    elif [[ "${Target,,}" == "${Candidate,,}" ]]
    then
        continue
    else
        for (( i=0; i<${#Target}; i++ ))
        do
            for (( j=0; j<${#Candidate}; j++ ))
            do
                TargetLetter=${Target:i:1}
                TargetLetter=${TargetLetter,,}
                CandidateLetter=${Candidate:j:1}
                CandidateLetter=${CandidateLetter,,}
                
                
                if [[ "${TargetLetter}" == "${CandidateLetter}" &&                                            "${TargetComplete:i:1}" != "_" && "${CandidateComplete:j:1}" != "_" ]]
                then
                    # echo "Target: ${TargetLetter}, Candidate:${CandidateLetter}" #Debug
                    TargetComplete="${TargetComplete/${TargetLetter}/_}"
                    CandidateComplete="${CandidateComplete/${CandidateLetter}/_}"
                    # echo "Debug: Underscore lettres ${TargetComplete}" #Debug
                    ((NumberOfIdenticalLetters++))
                    continue
                fi
            done
        done
    fi

    if [[ "${NumberOfIdenticalLetters}" -eq "${#Target}" && "${TargetComplete}" =~ ^_+$ && "${CandidateComplete}" =~ ^_+$ ]]
    then
        # echo "Debug: Different word with good candidate: ${Candidate}" #Debug
        if [[ -z "${Result}" ]]
        then
            Result="${Candidate}"
        else
            Result="${Result} ${Candidate}"
        fi
    fi
done

echo "${Result}"
exit 0
