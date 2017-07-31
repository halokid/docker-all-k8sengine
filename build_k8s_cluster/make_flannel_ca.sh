#!/bin/bash  


cfssl gencert -ca=/etc/kubernetes/ssl/ca.pem \
-ca-key=/etc/kubernetes/ssl/ca-key.pem \
-config=/etc/kubernetes/ssl/ca-config.json \
-profile=kubernetes flanneld-csr.json | cfssljson -bare flanneld  

ls flanneld*
sleep 5

#flanneld.csr  flanneld-csr.json  flanneld-key.pem flanneld.pem 

sudo mkdir -p /etc/flanneld/ssl
sudo mv flanneld*.pem /etc/flanneld/ssl
rm flanneld.csr  flanneld-csr.json




