#!/bin/bash
clear
echo "" > q4_output.txt 
while read -r a
do
    sed -i "s/\b$a\b//g" $1
    sed -i '/^$/d' $1
done < $2
#echo stopword have been removed from q4.txt
#echo the frequency will be found with precision as 2 decimal places
#read -r -p "Enter the word to search: " search
while read -r a
do
        searchcount=`echo $a | grep $3 -o | wc -w`
        wordcount=`echo $a | wc -w`
	#echo $a
        #echo searchcount= $searchcount
	#echo wordcount=$wordcount
	punctcount=`echo $a | grep " [.,:;'] " -o | wc -w`
	#echo punctcount=$punctcount
	wordcount=$(( $wordcount - $punctcount))
	if test $wordcount = "0"
	then
		echo "., 0" >> q4_output.txt
	else	
        termfreq=`echo " scale=2; $searchcount / $wordcount" | bc`
        #echo freq of $search in the above line is $termfreq
	echo "$a, 0$termfreq" >> q4_output.txt
	fi	
done < $1
