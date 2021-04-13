#!/bin/bash

host=hadoop103
scp src/tar/kafka-eagle-bin-2.0.4.tar.gz hadoop@${host}:/opt/module
scp src/scripts/kafka-eagle/eagle_config.sh hadoop@${host}:/home/hadoop/bin
ssh hadoop@${host} '/home/hadoop/bin/eagle_config.sh'
