#!/bin/bash

server_prefix='k8s'
scp src/scripts/k8s/only_for_master_node.sh root@${server_prefix}111:/root/bin

for((host=111; host<=113; host++)); do
  scp src/scripts/k8s/init_for_all_nodes.sh root@${server_prefix}${host}:/root/bin
  ssh root@${server_prefix}${host} '/root/bin/init_for_all_nodes.sh'
done

ssh root@${server_prefix}111 '/root/bin/only_for_master_node.sh'
