#!/bin/bash
clear
#echo input is taken from a text file called q3.txt
echo "1: Word start with 's' and is not followed by 'a'"
grep -o  "\bs[^a]\w*" $1
echo
echo "2: Word start with 'w' and is followed by 'h'"
grep -o "\bwh\w*" $1
echo
echo "3: Word start with 't' and is followed by 'h'"
grep -o "\bth\w*" $1
echo
echo "4: Word starts with 'a' and is not followed by 'n'"
grep -o "\ba[^n]\w*" $1
echo
