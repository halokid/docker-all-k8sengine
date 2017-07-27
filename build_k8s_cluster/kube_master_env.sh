#! /bin/bash  

export MASTER_IP=10.86.20.57  # 替换为当前部署的 master 机器 IP
 # 导入用到的其它全局变量：SERVICE_CIDR、CLUSTER_CIDR、NODE_PORT_RANGE、ETCD_ENDPOINTS、BOOTSTRAP_TOKEN
source /root/local/bin/environment.sh


