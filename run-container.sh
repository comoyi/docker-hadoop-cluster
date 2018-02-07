#!/bin/bash

image_version=0.0.1
hadoop_network=hadoop

# Create network
echo "create network: ${hadoop_network}"
docker network create ${hadoop_network}

# Start master
master_name="hadoop-master"
docker rm -f ${master_name} > /dev/null 2>&1
echo "start ${master_name}"
docker run -itd \
    --net=${hadoop_network} \
    -p 8088:8088 \
    -p 9870:9870 \
    --name "${master_name}" \
    --hostname "${master_name}" \
    comoyi/hadoop:${image_version} \
    > /dev/null

# Start slaves
n=3
i=1
while [ "$i" -le "$n" ]; do
    tmp_slave_name="hadoop-slave-$i"
    docker rm -f ${tmp_slave_name} > /dev/null 2>&1
    echo "start ${tmp_slave_name}"
    docker run -itd \
        --net=${hadoop_network} \
        --name "${tmp_slave_name}" \
        --hostname "${tmp_slave_name}" \
        comoyi/hadoop:${image_version} \
        > /dev/null
    i=$(($i + 1))
done
echo ""

# Show hadoop containers
docker ps | head -1
docker ps | grep hadoop

echo ""
echo "you can access hadoop-master by command: docker exec -it hadoop-master bash"
