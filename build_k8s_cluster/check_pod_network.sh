#!/bin/bash  


$ # 查看集群 Pod 网段(/16)
/root/local/bin/etcdctl \
--endpoints=${ETCD_ENDPOINTS} \
--ca-file=/etc/kubernetes/ssl/ca.pem \
--cert-file=/etc/flanneld/ssl/flanneld.pem \
--key-file=/etc/flanneld/ssl/flanneld-key.pem \
get ${FLANNEL_ETCD_PREFIX}/config
#{ "Network": "172.30.0.0/16", "SubnetLen": 24, "Backend": { "Type": "vxlan" } }


# 查看已分配的 Pod 子网段列表(/24)
/root/local/bin/etcdctl \
--endpoints=${ETCD_ENDPOINTS} \
--ca-file=/etc/kubernetes/ssl/ca.pem \
--cert-file=/etc/flanneld/ssl/flanneld.pem \
--key-file=/etc/flanneld/ssl/flanneld-key.pem \
ls ${FLANNEL_ETCD_PREFIX}/subnets
#/kubernetes/network/subnets/172.30.19.0-24


# 查看某一 Pod 网段对应的 flanneld 进程监听的 IP 和网络参数
/root/local/bin/etcdctl \
--endpoints=${ETCD_ENDPOINTS} \
--ca-file=/etc/kubernetes/ssl/ca.pem \
--cert-file=/etc/flanneld/ssl/flanneld.pem \
--key-file=/etc/flanneld/ssl/flanneld-key.pem \
#get ${FLANNEL_ETCD_PREFIX}/subnets/172.30.19.0-24  
#上面的地址改成 21 行输出的地址

#{"PublicIP":"10.64.3.7","BackendType":"vxlan","BackendData":{"VtepMAC":"d6:51:2e:80:5c:69"}}





