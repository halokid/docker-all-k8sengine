#!/bin/bash 

sudo cp kube-proxy.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable kube-proxy
sudo systemctl start kube-proxy
systemctl status kube-proxy



