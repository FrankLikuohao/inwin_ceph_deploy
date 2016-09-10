#!/bin/bash 
. ./frank_common.sh
ANSWER=0
while [ $ANSWER !=  "e" ]; do
         more mainlist
         echo "input no:"
		#ssh vmon1 "cat  notssdlist.txt"
		read ANSWER 
			#echo "$ANSWER"
		command=`ls 	$ANSWER.[a-Z]*`	
		. $command
		if [ $ANSWER = "e" ]; then
			exit 0;
		echo "previous action[$command ]"		
		fi 
		ANSWER=0 #reset the ANSWER	
done     
exit 0

