#!/bin/bash


INPUT=""

for line in $INPUT; do
  if [[ "$line" =~ ^([a-z\-]+)-([0-9]+)\[([a-z]+)\]$ ]]; then
    room_name=${BASH_REMATCH[1]}
    checksum=$(echo "$room_name" |
    awk '{ split($0,groups,"-"); for (i=1;i<=length(groups);i++){ split(groups[i],letters,""); for(j=1;j<=length(groups[i]);j++){ freq[letters[j]]++ } }} END { for (key in freq){ printf "%d\t%s\n", freq[key], key }}' |
    sort -k1,1nr -k2,2f |
    head -5 |
    cut -f2 |
    tr -d '\n')
    
    sector_string=${BASH_REMATCH[2]}
    if [[ "$checksum" =~ "${BASH_REMATCH[3]}" ]]; then
        sector=$((sector_string + 0))
        shift_value=$((sector % 26))
        alphabet_lower="abcdefghijklmnopqrstuvwxyz"
        
        shifted_lower="${alphabet_lower:${shift_value}}${alphabet_lower:0:${shift_value}}"
        
        decrypted=$(echo "$room_name" | tr "$alphabet_lower$alphabet_upper" "$shifted_lower$shifted_upper")
        if [[ "$decrypted" =~ "north" ]]; then
            echo $decrypted $sector
        fi
    fi
  fi
done
