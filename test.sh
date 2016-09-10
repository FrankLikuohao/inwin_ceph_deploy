#!/bin/bash 
. ./frank_common.sh
: <<'COMMENT'
newfile newfile1
remote_ssh vmon1 id-ssd
remote_ssh_para vmon1 id-ssd "file1 file2"
result=$(get_first_element_collumn host1:/dev/sdc:/dev/sdd host2:/dev/sde:/dev/sdf)
echo $result


COMMENT

result=$(get_first_element_by "host1:/dev/sdc:/dev/sdd host2:/dev/sde:/dev/sdf" :)
echo $result
print2null echo  "what the !@#$%"
