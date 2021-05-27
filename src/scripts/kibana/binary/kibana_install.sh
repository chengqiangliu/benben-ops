#!/bin/bash

host=hadoop101
scp src/tar/kibana-7.11.1-linux-x86_64.tar.gz hadoop@${host}:/opt/module
scp src/scripts/kibana/binary/kibana_config.sh hadoop@${host}:/home/hadoop/bin
ssh hadoop@${host} '/home/hadoop/bin/kibana_config.sh'
