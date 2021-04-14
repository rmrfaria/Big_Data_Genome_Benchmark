#!/bin/bash

network=""

#Create 3 ConfigServers
echo "Creating ConfigServers..."
sudo docker run --name mongo-config01 --net $network -d mongo mongod --configsvr --replSet configserver --port 27017
sudo docker run --name mongo-config02 --net $network -d mongo mongod --configsvr --replSet configserver --port 27017
sudo docker run --name mongo-config03 --net $network -d mongo mongod --configsvr --replSet configserver --port 27017

#Time to initiate ConfigServers
sleep 5s

# Servers Configuration
echo "Configuring Servers..."
sudo docker exec -it mongo-config01 mongo --eval "rs.initiate( \
   { \
      _id: 'configserver', \
      configsvr: true, \
      version: 1, \
      members: [ \
         { _id: 0, host : 'mongo-config01:27017' }, \
         { _id: 1, host : 'mongo-config02:27017' }, \
         { _id: 2, host : 'mongo-config03:27017' } \
      ] \
   } \
)"

#Create 3 Shards
echo "Creating Shards..."
#Shard 01
sudo docker run --name mongo-shard1a --net $network -d mongo mongod --port 27018 --shardsvr --replSet shard01
sudo docker run --name mongo-shard1b --net $network -d mongo mongod --port 27018 --shardsvr --replSet shard01

#Shard 02
sudo docker run --name mongo-shard2a --net $network -d mongo mongod --port 27019 --shardsvr --replSet shard02
sudo docker run --name mongo-shard2b --net $network -d mongo mongod --port 27019 --shardsvr --replSet shard02

#Shard 03
sudo docker run --name mongo-shard3a --net $network -d mongo mongod --port 27020 --shardsvr --replSet shard03
sudo docker run --name mongo-shard3b --net $network -d mongo mongod --port 27020 --shardsvr --replSet shard03

#Time to initiate Shards
sleep 5s

#Shards Configuration
echo "Configuring Shards..."
sudo docker exec -it mongo-shard1a mongo --port 27018 --eval "rs.initiate( \
   { \
      _id: 'shard01', \
      version: 1, \
      members: [ \
         { _id: 0, host : 'mongo-shard1a:27018' }, \
         { _id: 1, host : 'mongo-shard1b:27018' }, \
      ] \
   } \
)"

sudo docker exec -it mongo-shard2a mongo --port 27019 --eval "rs.initiate( \
   { \
      _id: 'shard02', \
      version: 1, \
      members: [ \
         { _id: 0, host : 'mongo-shard2a:27019' }, \
         { _id: 1, host : 'mongo-shard2b:27019' }, \
      ] \
   } \
)"

sudo docker exec -it mongo-shard3a mongo --port 27020 --eval "rs.initiate( \
   { \
      _id: 'shard03', \
      version: 1, \
      members: [ \
         { _id: 0, host : 'mongo-shard3a:27020' }, \
         { _id: 1, host : 'mongo-shard3b:27020' }, \
      ] \
   } \
)"

#Create Router
echo "Creating Router..."
sudo docker run -p 27017:27017 --name mongo-router --net $network -d mongo mongos --port 27017 --configdb configserver/mongo-config01:27017,mongo-config02:27017,mongo-config03:27017 --bind_ip_all

#Time to Initiate Router
sleep 5s

#Router Configuration to recognize shards
echo "Configuring Router to recognize shards..."
sudo docker exec -it mongo-router mongo --eval "sh.addShard('shard01/mongo-shard1a:27018'); sh.addShard('shard01/mongo-shard1b:27018'); \
sh.addShard('shard02/mongo-shard2a:27019'); sh.addShard('shard02/mongo-shard2b:27019'); \
sh.addShard('shard03/mongo-shard3a:27020'); sh.addShard('shard03/mongo-shard3a:27020');"

echo "Mongo Cluster Done!"
