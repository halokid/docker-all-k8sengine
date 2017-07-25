#! /bin/sh 

export NODE_NAME=etcd-host0 # 当前部署的机器名称(随便定义，只要能区分不同机器即可)
export NODE_IP=10.86.20.57 # 当前部署的机器 IP
export NODE_IPS="10.86.20.57 10.86.20.60 10.86.20.63" # etcd 集群所有机器 IP
# etcd 集群各机器名称和对应的IP、端口
export ETCD_NODES=etcd-host0=https://10.86.20.57:2380,etcd-host1=https://10.86.20.60:2380,etcd-host2=https://10.86.20.63:2380 



