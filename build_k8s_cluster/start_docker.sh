#!/bin/bash 

sudo cp docker.service /etc/systemd/system/docker.service
sudo systemctl daemon-reload
sudo systemctl stop firewalld
sudo systemctl disable firewalld
sudo iptables -F && sudo iptables -X && sudo iptables -F -t nat && sudo iptables -X -t nat
sudo systemctl enable docker 

echo "starting docker .................."
sleep 5

sudo systemctl start docker



