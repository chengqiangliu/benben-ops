#!/bin/bash

for((host=101; host<=103; host++)); do
  scp src/tar/hadoop-2.9.2.tar.gz hadoop@hadoop${host}:/opt/module
  scp src/scripts/hadoop/hadoop_config.sh hadoop@hadoop${host}:/home/hadoop/bin
  ssh hadoop@hadoop${host} '/home/hadoop/bin/hadoop_config.sh'

  scp src/scripts/hadoop/config/* hadoop@hadoop${host}:/opt/module/hadoop-2.9.2/etc/hadoop
done

