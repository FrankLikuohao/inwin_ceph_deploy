#!/bin/bash
. ./frank_common.sh
echo 
echo "exec b.chech remote health"
echo 
echo "input hostname:"
		 read ANSWER 	 	 
ssh $ANSWER "ceph -s" 
echo
