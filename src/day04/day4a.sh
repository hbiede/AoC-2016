#!/bin/bash


INPUT=""

count=0;
for line in $INPUT; do
  if [[ "$line" =~ ^([a-z\-]+)-([0-9]+)\[([a-z]+)\]$ ]]; then
    checksum=$(echo ${BASH_REMATCH[1]} |
    awk '{ split($0,groups,"-"); for (i=1;i<=length(groups);i++){ split(groups[i],letters,""); for(j=1;j<=length(groups[i]);j++){ freq[letters[j]]++ } }} END { for (key in freq){ printf "%d\t%s\n", freq[key], key }}' |
    sort -k1,1nr -k2,2f |
    head -5 |
    cut -f2 |
    tr -d '\n')
    
    sector_string=${BASH_REMATCH[2]}
    if [[ "$checksum" =~ "${BASH_REMATCH[3]}" ]]; then
        sector=$((sector_string + 0))
        count=$((count + sector))
    fi
  fi
done
echo $count
