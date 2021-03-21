#!/bin/bash

for((host=102; host<=103; host++)); do
  scp src/scripts/k8s/vm_init_config.sh root@hadoop${host}:/root
  ssh root@hadoop${host} '/root/vm_init_config.sh'
done
