#!/bin/bash

apt-get install sudo -y

apt-get purge "lxc-docker*" -y
apt-get purge "docker.io*" -y

sleep 3

apt-get update
apt-get install apt-transport-https ca-certificates gnupg2 -y


sudo apt-key adv \
       --keyserver hkp://ha.pool.sks-keyservers.net:80 \
       --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

       

       
       
sleep 3
echo "deb https://apt.dockerproject.org/repo debian-jessie main" > /etc/apt/sources.list.d/docker.list
sudo apt-get update

sleep 3
apt-cache policy docker-engine




sleep 3
sudo apt-get install sudo -y
sudo apt-get install docker-engine -y --force-yes
sudo service docker start
sudo docker run docker pull hub.c.163.com/r00txx/hello-world


sleep 5
sudo apt-get install python-pip python-dev -y
pip install -U docker-compose




