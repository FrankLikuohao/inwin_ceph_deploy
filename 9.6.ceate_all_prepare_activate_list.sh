#!/bin/bash 
. ./frank_common.sh
echo 
echo "exec 9.6.create_all_osd_prepare_activate_list and exec file(go.sh)"
echo 
echo "input hostname:"
		 read host 	
		  
ssh -t $host sudo "more notssdlist.txt"
prepare_all_program="./prepare_all.sh"
echo "if the above list right ?, please modify $host notssdlist.txt if it is wrong" 
echo
echo "input skip how many sd which are used by OS  data or ssd ex:2"
		 read skip_n
echo "input partition ssd ex:/dev/sdc"
		 read ssd_device



echo "$prepare_all_program $host $skip_n $ssd_device "
$prepare_all_program $host $skip_n $ssd_device 

#echo "create $((ls -al go.sh))"
#more  go.sh

echo "go ?(y/n)"
		 read answer
		 if [ $answer = "y" ]; then
			./go.sh
		 fi
 
