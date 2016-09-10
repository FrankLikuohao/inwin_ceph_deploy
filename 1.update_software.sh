#!/bin/bash
. ./frank_common.sh 
echo $0
sudo wget -q -O- 'https://ceph.com/git/?p=ceph.git;a=blob_plain;f=keys/release.asc' | sudo apt-key add -
sudo echo deb http://ceph.com/debian-firefly/ $(lsb_release -sc) main \ | sudo tee /etc/apt/sources.list.d/ceph.list

#deploy server 
sudo apt-get update -y && sudo apt-get install ceph-deploy -y
