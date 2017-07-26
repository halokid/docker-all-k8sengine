#! /bin/bash  

wget https://github.com/coreos/etcd/releases/download/v3.1.6/etcd-v3.1.6-linux-amd64.tar.gz
sleep 5
tar -xvf etcd-v3.1.6-linux-amd64.tar.gz
sleep 5
sudo mv etcd-v3.1.6-linux-amd64/etcd* /root/local/bin


