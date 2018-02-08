#!/bin/bash

# Start master
master_name="hadoop-master"
echo "Start ${master_name}"
docker start ${master_name} > /dev/null

# Start slaves
n=3
i=1
while [ "$i" -le "$n" ]; do
    tmp_slave_name="hadoop-slave-$i"
    echo "Start ${tmp_slave_name}"
    docker start ${tmp_slave_name} > /dev/null
    i=$(($i + 1))
done
echo ""

# Show hadoop containers
docker ps | head -1
docker ps | grep hadoop

printf "\n\033[32m[OK]\033[0m You can access container by command: \033[34mdocker exec -it ${master_name} bash\033[0m or \033[34m./init-tmux-session.sh\033[0m\n"
