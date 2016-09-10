#!/bin/bash
. ./frank_common.sh
echo 
echo "exec p.purge_data_ceph_program.sh"
echo 
echo "input hosts' name:"
		 read ANSWER 
echo "******remote host is $ANSWER"
echo "******ceph-deploy purge $ANSWER*******"
ceph-deploy purge $ANSWER		 	 
echo "*****ceph-deploy purgedata $ANSWER******"
ceph-deploy purgedata $ANSWER
echo "*****ceph-deploy forgetkeys******"
ceph-deploy forgetkeys
