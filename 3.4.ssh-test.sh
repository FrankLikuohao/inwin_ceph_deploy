#!/bin/bash 
echo 
echo "exec 3.4 ssh uname -r remote_a_host [$1]"
echo 
echo "input hostname:"
		 read ANSWER 
echo "remote host is"		 	 
ssh $ANSWER uname -ra 
echo
