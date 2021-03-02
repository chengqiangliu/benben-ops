#!/bin/bash

for((host=101; host<=103; host++)); do
  scp src/tar/kafka_2.12-2.6.1.tgz hadoop@hadoop${host}:/opt/module
  scp src/scripts/kafka/kafka_config.sh hadoop@hadoop${host}:/home/hadoop/bin
  ssh hadoop@hadoop${host} '/home/hadoop/bin/kafka_config.sh'
done

