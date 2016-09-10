#!/bin/bash  -xv
. ./frank_common.sh
echo 
echo "exec 9.z.ceph-disk zap host1:/dev/sdb [host2:/dev/sdb host3:/dev/sdb]"
echo 
echo "input hostname:"
		 read -e host 	
ceph-deploy disk zap $host
		  

