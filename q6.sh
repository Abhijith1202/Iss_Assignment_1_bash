#!/bin/bash
echo
declare -A optionarr

while getopts ":C:f:l:n:o:k:c:v:ad" optname; do
	case $optname in
		C)
			optionarr["C"]=$OPTARG
			;;
		f)
			optionarr["f"]=$OPTARG
			;;
		l)      
                        optionarr["l"]=$OPTARG
                        ;;
		n)
                        optionarr["n"]=$OPTARG
                        ;;
		o)      
                        optionarr["o"]=$OPTARG
                        ;;
		k)      
                        optionarr["k"]=$OPTARG
                 	;;
		c)
                        optionarr["c"]=$OPTARG
                        ;;
		v)
                        optionarr["v"]=$OPTARG
                        ;;
		a)
                        optionarr["a"]="yes"
						optionarr["d"]="no"
                        ;;
		d)
                        optionarr["d"]="yes"
						optionarr["a"]="no"
                        ;;
		*)
			echo invalid flag
			;;
	esac
done
if [ ${optionarr["C"]} == "insert" ]
then
	echo ${optionarr["f"]},${optionarr["l"]},${optionarr["n"]},${optionarr["o"]} >> contacts.csv
elif [ ${optionarr["C"]} == "edit" ]
then
	nr=`cat contacts.csv | awk -F "," '{print $1}' | grep -n "${optionarr["k"]}" | awk -F ":" '{print $1}'`
	fn=`sed -n ''$nr''p contacts.csv | awk -F "," '{print $1}'`
	#echo $fn
	ln=`sed -n ''$nr''p contacts.csv | awk -F "," '{print $2}'`
	cnum=`sed -n ''$nr''p contacts.csv | awk -F "," '{print $3}'`
	on=`sed -n ''$nr''p contacts.csv | awk -F "," '{print $4}'`
	sed -i 's/\b'$fn',/'${optionarr["f"]}',/' contacts.csv
	#echo $fn
	#echo fn changed
	sed -i 's/,'$ln',/,'${optionarr["l"]}',/' contacts.csv
	#echo ln changed
	sed -i 's/,'$cnum',/,'${optionarr["n"]}',/' contacts.csv
	#echo number changed
	#echo $on
	sed -i "s/^\(${optionarr["f"]},[^,]*,[^,]*,\)[^,]*/\1${optionarr["o"]}/" contacts.csv
	#echo op changed
elif [ ${optionarr["C"]} == "display" ]
then
	if [ ${optionarr["a"]} == "yes" ]
	then
		sort contacts.csv
	else
		sort -r contacts.csv
	fi	

elif [ ${optionarr["C"]} == "search" ]
then
	if [ ${optionarr["c"]} == "fname" ]
	then
		nl=`cat contacts.csv | awk -F "," '{print $1}' | grep -n ${optionarr["v"]} | awk -F ":" '{print $1}'`
		#echo line number= $nl
		sed -n ''$nl''p contacts.csv
	elif [ ${optionarr["c"]} == "lname" ]
	then
		nl=`cat contacts.csv | awk -F "," '{print $2}' | grep -n ${optionarr["v"]} | awk -F ":" '{print $1}'`
		sed -n ''$nl''p contacts.csv
	else
		nl=`cat contacts.csv | awk -F "," '{print $3}' | grep -n ${optionarr["v"]} | awk -F ":" '{print $1}'`
		sed -n ''$nl''p contacts.csv
	fi

elif [ ${optionarr["C"]} == "delete" ]
then
	if [ ${optionarr["c"]} == "fname" ]
	then
		nl=`cat contacts.csv | awk -F "," '{print $1}' | grep -n ${optionarr["v"]} | awk -F ":" '{print $1}'`
		#echo line number= $nl
		sed -i ''$nl'd' contacts.csv
	elif [ ${optionarr["c"]} == "lname" ]
	then
		nl=`cat contacts.csv | awk -F "," '{print $2}' | grep -n ${optionarr["v"]} | awk -F ":" '{print $1}'`
		sed -i ''$nl'd' contacts.csv
	else
		nl=`cat contacts.csv | awk -F "," '{print $3}' | grep -n ${optionarr["v"]} | awk -F ":" '{print $1}'`
		sed -i ''$nl'd' contacts.csv
	fi
else
	echo invalid option
	exit
fi
