#!/bin/bash

host=hadoop103
scp src/tar/mysql80-community-release-el7-3.noarch.rpm hadoop@${host}:/opt/module
scp src/scripts/mysql/mysql_config.sh hadoop@${host}:/home/hadoop/bin
ssh hadoop@${host} '/home/hadoop/bin/mysql_config.sh'
