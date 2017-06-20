#!/bin/sh 

docker rm $(docker ps -q -a)
