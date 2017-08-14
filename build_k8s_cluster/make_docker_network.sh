#!/bin/bash 


service docker stop
echo "stopping docker ............"
sleep 5 
source /run/flannel/subnet.env
ifconfig docker0 ${FLANNEL_SUBNET}
echo "DOCKER_OPTS="--bip=${FLANNEL_SUBNET} --mtu=${FLANNEL_MTU} --ip-masq=true"" >> /etc/default/docker    #这句最重要，写入docker的启动参数

#echo "starting docker ............"
#service docker start 




