#!/bin/bash  

#wget https://dl.k8s.io/v1.6.2/kubernetes-server-linux-amd64.tar.gz
tar -xzvf kubernetes-server-linux-amd64.tar.gz
cd kubernetes
tar -xzvf  kubernetes-src.tar.gz

sleep 5
sudo cp -r ./server/bin/{kube-proxy,kubelet} /root/local/bin/ 




