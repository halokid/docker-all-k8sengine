#!/bin/bash 

# 替换为 kubernetes master 集群任一机器 IP
export MASTER_IP=10.86.20.57
export KUBE_APISERVER="https://${MASTER_IP}:6443"
# 当前部署的节点 IP
export NODE_IP=10.86.20.60
# 导入用到的其它全局变量：ETCD_ENDPOINTS、FLANNEL_ETCD_PREFIX、CLUSTER_CIDR、CLUSTER_DNS_SVC_IP、CLUSTER_DNS_DOMAIN、SERVICE_CIDR
source /root/local/bin/environment.sh 


