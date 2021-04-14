#!/bin/bash

HOSTCOUNT=${1:-3}
VERSION="latest"
NETWORK=""

echo "Host count: " ${HOSTCOUNT}

#Form the host list
PREFIX="node"
for i in `seq 1 $HOSTCOUNT`
do
	NAME=${PREFIX}${i}
	if [ -n "${HOSTS}" ]; then
	    HOSTS="${HOSTS},${NAME}"
	else
	    HOSTS="${NAME}"
	fi
done

echo "Host list: " ${HOSTS}

for i in `seq 1 $HOSTCOUNT`
do
	NAME=${PREFIX}${i}

	sudo docker run -d -P \
		-e HOST_COUNT=$HOSTCOUNT \
		-e HOSTS=$HOSTS \
		--name=$NAME \
		--network=$NETWORK \
		voltdb/voltdb-community:$VER
done
