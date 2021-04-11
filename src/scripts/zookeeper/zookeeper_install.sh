#!/bin/bash

for((host=101; host<=103; host++)); do
  scp src/tar/apache-zookeeper-3.6.2-bin.tar.gz hadoop@hadoop${host}:/opt/module
  scp src/scripts/zookeeper/zookeeper_config.sh hadoop@hadoop${host}:/home/hadoop/bin
  scp src/scripts/zookeeper/zookeeper.sh hadoop@hadoop${host}:/home/hadoop/bin
  ssh hadoop@hadoop${host} '/home/hadoop/bin/zookeeper_config.sh'
done

