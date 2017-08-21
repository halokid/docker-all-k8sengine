#!/bin/bash 

sudo mkdir /var/lib/kubelet # 必须先创建工作目录 
sleep 3
cat > kubelet.service <<EOF




