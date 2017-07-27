#!/bin/bash 

mkdir flannel
#wget https://github.com/coreos/flannel/releases/download/v0.7.1/flannel-v0.7.1-linux-amd64.tar.gz
tar -xzvf flannel-v0.7.1-linux-amd64.tar.gz -C flannel
sleep 3
sudo cp flannel/{flanneld,mk-docker-opts.sh} /root/local/bin



