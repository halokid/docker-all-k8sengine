#!/bin/bash 

sudo cp flanneld.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable flanneld
sudo systemctl start flanneld
sleep 3
systemctl status flanneld



