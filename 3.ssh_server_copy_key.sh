#!/bin/bash
. ./frank_common.sh
echo 
echo "exec 3.ssh_server_copy_Key"
echo
ANSWER=0
while [ $ANSWER !=  "r" ]; do
         more 3mainlist
         echo "input no:"
		 read ANSWER 
		 if [ $ANSWER = 'r' ]; then
		 . ./0.auto-deploy.sh
		 fi		 
			#echo "$ANSWER"
		command=`ls 	3.$ANSWER.*`
		. $command
		echo "previous action[$command ]"	
		ANSWER=0 #reset the ANSWER	
done    
echo 
