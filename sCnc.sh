#!/bin/bash

echo "TARGET: $1"
echo "------------------"
echo "Puertos: 65535"
echo "------------------"
echo "Protocolo: $2"
echo "------------------"
echo ""


for i in {1..65535}
do
	if [[ $2 == tcp ]] || [[ $2 == Tcp ]] || [[ $2 == TCP ]]
	then
		scan_tcp=$(netcat -vz \-w 1 $1 $i &> .scan)
		result=$(grep -o "open" .scan)

		if [[ $result == "open" ]]
		then
			echo "Port $i OPEN - SERVICE $(egrep -o "\((.*?)\)" .scan)"
		else
			echo -n ""
		fi
	else
		scan_udp=$(netcat -zu $1 $i)
		echo "$scan_udp"
	fi

done
echo ""
echo "sCnc - Kedr"