#!/bin/bash 
. ./frank_common.sh
echo 
echo "exec 9.5.batch_partition_hd.sh"
echo 
echo "input hostname:"
		 read host 	 
#rcp id_ssd and run to get the notssdlist.txt


id_ssd="./id-ssd"
scp ./$id_ssd $host:~
ssh -t $host "~/$id_ssd"

part_program="./ceph-auto-part.sh"
scp ./$part_program $host:~


echo "input device name ex:/dev/sdb"
	read device_name

echo "input size (GB) ex:2"
	read size

echo "input Hown many partitions? ex:3"
	read no_partition
	
#$part_program
#echo "input parameter"
#read -e ANSWER 	
ssh -t $host sudo chmod a+x  $part_program	 
ssh -t $host "~/$part_program $device_name $size $no_partition"
ssh -t $host sudo "\rm -f $id_ssd $part_program"
