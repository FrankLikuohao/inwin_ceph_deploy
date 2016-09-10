#!/bin/bash 
. ./frank_common.sh
echo 
echo "exec 9.1.idenfigy_ssd.sh"
echo 
echo "input hostname:"
		 read host 	 
#rcp id_ssd and run to get the notssdlist.txt
id_ssd="./id-ssd"
scp ./$id_ssd $host:~
ssh -t $host "~/$id_ssd"
