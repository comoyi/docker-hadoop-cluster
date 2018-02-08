#! /bin/bash

#
# Create a tmux session for manage hadoop cluster
#

# Check if tmux is already installed
which tmux > /dev/null 2>&1
if [[ $? -ne 0 ]]; then
    printf "\033[31mPlease install \033[1mtmux\033[0m\033[31m first!\033[0m\n"
    exit 1
fi

# session name
session_hadoop_cluster='hadoop-cluster'

# init
function init_session_hadoop_cluster()
{
    # hadoop-master
    master_name="hadoop-master"
    tmux -2 new-session -d -s ${session_hadoop_cluster} -n ${master_name}
    tmux send-keys -t "${session_hadoop_cluster}:${master_name}" "docker exec -it ${master_name} bash" C-m
   
    # hadoop-slave
    n=3 # slave quantity
    i=1
    while [ "$i" -le "$n" ]; do
        # hadoop-slave-n
        tmp_slave_name="hadoop-slave-${i}"
        tmux new-window -d -t ${session_hadoop_cluster} -n ${tmp_slave_name}
        tmux send-keys -t "${session_hadoop_cluster}:${tmp_slave_name}" "docker exec -it ${tmp_slave_name} bash" C-m

        i=$(($i + 1))
    done

    # Choose a window
    tmux select-window -t ${master_name}
}

tmux has-session -t ${session_hadoop_cluster}
if [ $? != 0 ]; then
    init_session_hadoop_cluster
else
    tmux kill-session -t ${session_hadoop_cluster}
    init_session_hadoop_cluster
fi

tmux -2 attach-session -t ${session_hadoop_cluster}
