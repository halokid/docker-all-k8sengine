#!/bin/bash  

cfssl gencert -ca=/etc/kubernetes/ssl/ca.pem \
-ca-key=/etc/kubernetes/ssl/ca-key.pem \
-config=/etc/kubernetes/ssl/ca-config.json \
-profile=kubernetes admin-csr.json | cfssljson -bare admin

sleep 5
ls admin*
sleep 5
sudo mv admin*.pem /etc/kubernetes/ssl/
rm admin.csr admin-csr.json 



