#!/bin/sh 

docker run -it -p 80:80 -p 3306:3306  -p 3000:3000 -p 8083:8083 -p 8086:8086 hub.c.163.com/r00txx/grafana
