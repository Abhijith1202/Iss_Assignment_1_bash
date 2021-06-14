#!/bin/bash
cat $1 | awk '{ print $1 }' | tr '\n' ',' > q2_output.txt 
a=`cat $1 | awk '{ print $2}'`
#echo $a (works, gives dd/mm/yyyy)
dd=`echo $a | awk -F "/" '{print $1}'`
#echo $dd
mm=`echo $a | awk -F "/" '{print $2}'`
yy=`echo $a | awk -F "/" '{print $3}'`
#echo $dd / $mm / $yy
currd=`date +%d`
currm=`date +%m`
curry=`date +%Y`
#echo $currd
if [ "$currm" -gt "$mm" ]
then
	#echo $curry
	#echo $yy
	yearage=`expr $curry - $yy`
	monthage=`expr $currm - $mm`
	#echo yearage = $yearage

elif [ "$currm" -lt "$mm" ]
then
        monthage=`expr $currm + 12`
	monthage=`expr $monthage - $mm`
	yearage=`expr $curry - $yy`
	yearage=`expr $yearage - 1`
	#echo age: $yearage years $monthage months

elif [ "$currd" -gt "$dd" ]
then
	yearage=`expr $curry - $yy`
        monthage=`expr $currm - $mm`

else
	monthage=`expr $currm + 12`
        monthage=`expr $monthage - $mm`
        yearage=`expr $curry - $yy`
        yearage=`expr $yearage - 1`
fi
if [ "$monthage" -gt "6" ]
then
	yearage=`expr $yearage + 1`
fi
echo age: $yearage years >> "q2_output.txt"
#echo "age: $yearage years $monthage months" | tee -a q2out.txt
