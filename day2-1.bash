#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

function math () {
	expr=$(cat -)
	echo $(( $expr ))
}

function decFromHex () {
	dec1=$(printf "%d" $((16#$1)))
	dec2=$(printf "%d" $((16#$2)))
	echo $(( $dec1 - $dec2 ))
}

function getScore () {
	IFS=' ' elts=($line)
	play1=$(decFromHex ${elts[0]} '40') 
	play2=$(decFromHex ${elts[1]} '57')

	if [ $play1 -eq $play2 ]; then
		echo $(( $play2 + 3 ))
	elif (( $play2 - $play1 == 1 )) || (( $play2 - $play1 == -2 )); then
		echo $(( $play2 + 6 ))
	else
		echo $play2
	fi
}

xxd -g 1 -c 4 | cut -d' ' -f 2,4 | while read line; do getScore $line; done | head -c -1 | sed -z 's/\n/+/g' | math
