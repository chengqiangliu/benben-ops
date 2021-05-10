#!/bin/bash

host=vm201
scp src/scripts/redis-cluster/setup.sh root@${host}:/root/bin
ssh root@${host} '/root/bin/setup.sh'
