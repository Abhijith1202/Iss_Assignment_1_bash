#!/bin/bash
clear
while read -r a
do
	b=${#a}
	echo ${a:0:4} | tr -d '\n'
	if [[ $b -gt 4 ]]
	then
		for ((i=4;i<$b;i++))
		do
			echo "#" | tr -d '\n'
		done
	fi
	echo
done<$1
