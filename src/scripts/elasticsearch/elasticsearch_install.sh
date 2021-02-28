#!/bin/bash

for((host=101; host<=103; host++)); do
  scp src/tar/elasticsearch-7.11.1-linux-x86_64.tar.gz hadoop@hadoop${host}:/opt/module
  scp src/scripts/elasticsearch/elasticsearch_config.sh hadoop@hadoop${host}:/home/hadoop/bin
  ssh hadoop@hadoop${host} '/home/hadoop/bin/elasticsearch_config.sh'
done

