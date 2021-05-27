#!/bin/bash

server_prefix='vm'
host=201
scp src/scripts/kibana/docker/kibana_setup.sh root@${server_prefix}${host}:/root/bin
ssh root@${server_prefix}${host} '/root/bin/kibana_setup.sh'

