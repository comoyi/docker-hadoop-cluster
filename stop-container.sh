#!/bin/bash

# Stop master
master_name="hadoop-master"
echo "stop ${master_name}"
docker stop ${master_name} > /dev/null 2>&1

# Stop slaves
n=3
i=1
while [ "$i" -le "$n" ]; do
    tmp_slave_name="hadoop-slave-$i"
    echo "stop ${tmp_slave_name}"
    docker stop ${tmp_slave_name} > /dev/null 2>&1
    i=$(($i + 1))
done
echo ""

# Show hadoop containers
docker ps | head -1
docker ps | grep hadoop
