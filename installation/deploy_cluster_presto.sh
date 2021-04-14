#!/bin/bash

network=""

sudo docker run -p 8082:8080 --name coordinator --net $network ahanaio/prestodb-sandbox
sudo docker run -p 8083:8080 --name worker1 --net $network ahanaio/prestodb-sandbox
sudo docker run -p 8084:8080 --name worker2 --net $network ahanaio/prestodb-sandbox
