#! /bin/bash 

#-------- config etcd -----------
sudo mv etcd.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable etcd
sudo systemctl start etcd  

#--------- run etcd  和上面分开执行 -----------
echo "sleep 5 seconds"
sleep 5
systemctl status etcd



