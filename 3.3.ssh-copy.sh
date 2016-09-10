#!/bin/bash
echo 
echo "exec 3.3 ssh-copy-id a_host"
echo 
echo "input hostname:"
		 read  ANSWER 	 
ssh-copy-id $ANSWER

#reset the muti-input to original input(otherwise return a lot of unknown command)
#ANSWER="3"
