#!/bin/bash



# ------------- Master 开始 --------------


# 运行 ectd 容器
echo "Starting ectd container..."
sudo docker run -d --name="etcd" index.alauda.cn/kiwenlau/etcd:v2.2.1 \
                                      --addr=127.0.0.1:4001 \
                                      --bind-addr=0.0.0.0:4001 \
                                      --data-dir=/var/etcd/data 

# 运行 apiserver 容器
echo "Starting apiserver container..."
sudo docker run -d --link etcd:etcd --name="apiserver" index.alauda.cn/kiwenlau/kubernetes:1.0.7 kube-apiserver \
                                                         --service-cluster-ip-range=10.0.0.1/24 \
                                                         --insecure-bind-address=0.0.0.0 \
                                                         --etcd_servers=http://etcd:4001

sleep 10


# 运行 controller-manager 容器
echo "Starting controller-manager container..."
sudo docker run -d --link apiserver:apiserver --name="controller-manager" index.alauda.cn/kiwenlau/kubernetes:1.0.7 kube-controller-manager --master=http://apiserver:8080                                                                           

# 运行 scheduler 容器
echo "Starting scheduler container..."
sudo docker run -d --link apiserver:apiserver --name="scheduler" index.alauda.cn/kiwenlau/kubernetes:1.0.7 kube-scheduler --master=http://apiserver:8080 

# ------------- Master 结束 --------------



# ------------- Slave 开始 --------------

# 运行 kubelet 容器
echo "Starting kubelet container..."
sudo docker run -d --link apiserver:apiserver --pid=host -v /var/run/docker.sock:/var/run/docker.sock --name="kubelet"  index.alauda.cn/kiwenlau/kubernetes:1.0.7 kubelet \
                                                                                                                      --api_servers=http://apiserver:8080 \
                                                                                                                      --address=0.0.0.0 \
                                                                                                                      --hostname_override=127.0.0.1 \
                                                                                                                      --cluster_dns=10.0.0.10 \
                                                                                                                      --cluster_domain="kubernetes.local" \
                                                                                                                      --pod-infra-container-image="index.alauda.cn/kiwenlau/pause:0.8.0"
                                                                                                   
# Run proxy container
echo "Starting proxy container..."
sudo docker run -d --link apiserver:apiserver --privileged --name="proxy" index.alauda.cn/kiwenlau/kubernetes:1.0.7 kube-proxy --master=http://apiserver:8080 


# ------------- Slave 结束 --------------




# ------------- kube客户端开始 --------------

#Run kubectl container
echo "Starting kubectl container..."                                                                 
sudo docker run -id --link apiserver:apiserver -e "KUBERNETES_MASTER=http://apiserver:8080" --name="kubectl" --hostname="kubectl" index.alauda.cn/kiwenlau/kubernetes:1.0.7 bash 

#Get into the kubectl container
sudo docker exec -it kubectl bash

# ------------- kube客户端结束 --------------



