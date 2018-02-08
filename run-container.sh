#!/bin/bash

image_version=0.0.1
hadoop_network=hadoop-cluster

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
    -p 19888:19888 \
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

printf "\n\033[32m[OK]\033[0m You can access ${master_name} by command: \033[34mdocker exec -it ${master_name} bash\033[0m\n"
