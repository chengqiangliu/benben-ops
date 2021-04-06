#!/bin/bash

server_prefix='k8s'
for((host=102; host<=103; host++)); do
  scp src/scripts/k8s/vm_init_config.sh root@${server_prefix}${host}:/root
  ssh root@${server_prefix}${host} '/root/vm_init_config.sh'
done
