#!/bin/bash

server_prefix='vm'
for((host=201; host<=203; host++)); do
  scp src/scripts/docker/nacos_config.sh hadoop@${server_prefix}${host}:/home/hadoop/bin
  ssh hadoop@${server_prefix}${host} '/home/hadoop/bin/nacos_config.sh'
done

