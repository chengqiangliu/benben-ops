#!/bin/bash

host=vm203
scp src/scripts/mysql-cluster/setup.sh root@${host}:/root/bin
scp src/scripts/mysql-cluster/master-setting.sql root@${host}:/root/bin
scp src/scripts/mysql-cluster/slave-setting.sql root@${host}:/root/bin
ssh root@${host} '/root/bin/setup.sh'
