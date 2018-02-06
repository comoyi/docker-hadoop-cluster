#!/bin/bash

# Start master
master_name="hadoop-master"
echo "start ${master_name}"
docker start ${master_name} > /dev/null

# Start slaves
n=3
i=1
while [ "$i" -le "$n" ]; do
    tmp_slave_name="hadoop-slave-$i"
    echo "start ${tmp_slave_name}"
    docker start ${tmp_slave_name} > /dev/null
    i=$(($i + 1))
done
echo ""

# Show hadoop containers
docker ps | head -1
docker ps | grep hadoop