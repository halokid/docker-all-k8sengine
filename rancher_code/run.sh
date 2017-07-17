#!/bin/bash 


$ sudo docker run -d --restart=unless-stopped -p 8080:8080 rancher/server:latest
# Tail the logs to show Rancher
#$ sudo docker logs -f <CONTAINER_ID>
