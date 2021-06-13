#!/bin/bash
clear
if test "$1" = ""
then
    cd $PWD
else
    cd $1
fi

find -mindepth 1 -type d > q5temp1

touch q5temp2
touch q5temp1

while read -r a
do
    echo $a | tr '\n' ' ' >> q5temp2
    find $a -type f | wc -l >> q5temp2
    # echo >> q5temp2
done < q5temp1

#cat q5temp1
#cat q5temp2
cat q5temp2 > q5temp1

sort -r -n "-k 2" q5temp1 > q5temp2
echo "" > q5temp1
while read -r a
do
    echo $a | tr '/' ' ' | awk '{print ">",$(NF-1),",",$NF,"file(s)"}' >> q5temp1
done < q5temp2

rm q5temp2

echo ">Directories:" | tr -d '\n' 
cat q5temp1
rm q5temp1

echo ">"
echo ">Files:"
ls -lSR | grep "^-" | awk '{print ">",$NF,$5}' | sort -r -n "-k 3" | awk 'NF{NF--};1'
