#!/bin/bash 

sudo mkdir -p /var/lib/kube-proxy # 必须先创建工作目录
cat > kube-proxy.service <<EOF
[Unit]
Description=Kubernetes Kube-Proxy Server
Documentation=https://github.com/GoogleCloudPlatform/kubernetes
After=network.target

[Service]
WorkingDirectory=/var/lib/kube-proxy
ExecStart=/root/local/bin/kube-proxy \\
--bind-address=${NODE_IP} \\
--hostname-override=${NODE_IP} \\
--cluster-cidr=${SERVICE_CIDR} \\
--kubeconfig=/etc/kubernetes/kube-proxy.kubeconfig \\
--logtostderr=true \\
--v=2
Restart=on-failure
RestartSec=5
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
EOF 


