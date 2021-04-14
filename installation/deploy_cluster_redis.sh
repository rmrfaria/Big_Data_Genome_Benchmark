#!/bin/bash

network=""

# Deploy only one node
#sudo docker run --name redis-1 --net $network -d redis

#Create Redis Cluster

sudo docker run -d -v \
     $PWD/node1/cluster-config.conf:/usr/local/etc/redis/redis.conf \
     --name redis-1 --net $network \
     redis redis-server /usr/local/etc/redis/redis.conf

sudo docker run -d -v \
     $PWD/node2/cluster-config.conf:/usr/local/etc/redis/redis.conf \
     --name redis-2 --net $network \
     redis redis-server /usr/local/etc/redis/redis.conf

sudo docker run -d -v \
     $PWD/node3/cluster-config.conf:/usr/local/etc/redis/redis.conf \
     --name redis-3 --net $network \
     redis redis-server /usr/local/etc/redis/redis.conf

sudo docker run -d -v \
     $PWD/node4/cluster-config.conf:/usr/local/etc/redis/redis.conf \
     --name redis-4 --net $network \
     redis redis-server /usr/local/etc/redis/redis.conf

sudo docker run -d -v \
     $PWD/node5/cluster-config.conf:/usr/local/etc/redis/redis.conf \
     --name redis-5 --net $network \
     redis redis-server /usr/local/etc/redis/redis.conf

sudo docker run -d -v \
     $PWD/node6/cluster-config.conf:/usr/local/etc/redis/redis.conf \
     --name redis-6 --net $network \
     redis redis-server /usr/local/etc/redis/redis.conf

IP_REDIS1=`sudo docker inspect -f '{{ (index .NetworkSettings.Networks "$network").IPAddress }}' redis-1`
IP_REDIS2=`sudo docker inspect -f '{{ (index .NetworkSettings.Networks "$network").IPAddress }}' redis-2`
IP_REDIS3=`sudo docker inspect -f '{{ (index .NetworkSettings.Networks "$network").IPAddress }}' redis-3`#IP_REDIS4=`sudo docker inspect -f '{{ (index .NetworkSettings.Networks "$network").IPAddress }}' redis-4`
IP_REDIS5=`sudo docker inspect -f '{{ (index .NetworkSettings.Networks "$network").IPAddress }}' redis-5`
IP_REDIS6=`sudo docker inspect -f '{{ (index .NetworkSettings.Networks "$network").IPAddress }}' redis-6`

sudo docker run -i --rm --net $network redis redis-cli \
     --cluster create $IP_REDIS1:7001 $IP_REDIS2:7002 $IP_REDIS3:7003 $IP_REDIS4:7004 $IP_REDIS5:7005 $IP_REDIS6:7006 \
     --cluster-replicas 1
