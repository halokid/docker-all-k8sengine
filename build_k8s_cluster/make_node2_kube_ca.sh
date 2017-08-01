#!/bin/bash 

cfssl gencert -ca=/etc/kubernetes/ssl/ca.pem \
-ca-key=/etc/kubernetes/ssl/ca-key.pem \
-config=/etc/kubernetes/ssl/ca-config.json \
-profile=kubernetes  kube-proxy-csr.json | cfssljson -bare kube-proxy 

ls kube-proxy*
#kube-proxy.csr  kube-proxy-csr.json  kube-proxy-key.pem  kube-proxy.pem 

sudo mv kube-proxy*.pem /etc/kubernetes/ssl/
#rm kube-proxy.csr  kube-proxy-csr.json 



