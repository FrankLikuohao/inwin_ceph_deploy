#!/bin/bash -xv
. ./frank_common.sh
echo 
echo "exec c.create ceph fs"
echo

echo "input mds(in cluster)"
		 read  host 
echo "mds hosts are [$host]"
echo "ssh -t $host "ceph-deploy mds create $host""
ceph-deploy mds create $host
ssh -t $host "ceph osd pool create cephfs_metadata 64"
ssh -t $host "ceph osd pool create cephfs_data 64"
ssh -t $host "ceph fs new ceph_fs cephfs_metadata cephfs_data"
echo "-t $host ceph mds stat"
ssh -t $host "ceph mds stat"
echo "ssh -t $host ceph fs ls"
ssh -t $host "ceph fs ls"

#複製ceph.client.admin.keyring至client的/etc/ceph
#sudo apt-get install ceph-fuse
#sudo mkdir ~/mycephfs
#sudo ceph-fuse -m {ip-address-of-monitor}:6789 ~/mycephfs
#df
ssh -t $host "ceph -s"
echo "input monitor ip:port (172.22.3.2:6789)"
read ip_port
ssh -t $host "sudo apt-get install ceph-fuse -y"

mycephfs="/mnt/mycephfs"
echo "sudo mkdir  $mycephfs"
ssh -t $host "sudo mkdir  $mycephfs"

echo "ssh $host sudo ceph-fuse -m $ip_port $mycephfs"

ssh $host "sudo ceph-fuse -m $ip_port $mycephfs ;df -h"
ssh -t $host "sudo chmod 777 $mycephfs"
ssh -t $host "df -h"


echo "samba sever"
ssh -t $host "sudo apt-get install samba -y"

ssh -t $host "sudo chmod a+w /etc/samba/smb.conf"

config="
[Guest Share] \n
        comment = Guest access share \n
        path = $mycephfs \n
        browseable = yes \n
        writeable = yes \n
        guest ok = yes \n
"
config2="
 
[myshare] \n
path = /  \n
writeable = yes \n
path=$mycephfs \n"

tmpfile="/tmp/tmpconfig"
echo -e $config > $tmpfile
echo -e $config2 >> $tmpfile
scp $tmpfile $host:/$tmpfile

echo "ssh -t $host cat $tmpfile >> /etc/samba/smb.conf"
ssh  $host "cat $tmpfile >> /etc/samba/smb.conf"
ssh -t $host "sudo chmod go-r /etc/samba/smb.conf"

ssh -t $host "sudo service smbd restart"
ssh -t $host "sudo service nmbd restart"


#remove
#sudo apt-get remove ceph-mds -y
#sudo apt-get remove --auto-remove ceph-mds -y

#sudo apt-get purge ceph-mds -y
#sudo apt-get purge --auto-remove ceph-mds -y
 
