#!/bin/bash  

journalctl  -u flanneld |grep 'Lease acquired'
ifconfig flannel.1

