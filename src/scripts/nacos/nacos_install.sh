#!/bin/bash

server_prefix='vm'
host=201
scp src/scripts/docker/nacos_config.sh hadoop@${server_prefix}${host}:/home/hadoop/bin
ssh hadoop@${server_prefix}${host} '/home/hadoop/bin/nacos_config.sh'
