#!/bin/bash  

for ip in ${NODE_IPS}; do
ETCDCTL_API=3 /root/local/bin/etcdctl \
--endpoints=https://${ip}:2379  \
--cacert=/etc/kubernetes/ssl/ca.pem \
--cert=/etc/kubernetes/ssl/kubernetes.pem \
--key=/etc/kubernetes/ssl/kubernetes-key.pem \
endpoint health; done



