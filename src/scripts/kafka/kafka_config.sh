#!/bin/bash

# move into /opt/module folder
cd /opt/module

echo "untar kafka ..."
tar -xvzf kafka_2.12-2.6.1.tgz

echo "removing kafka_2.12-2.6.1.tgz tar file..."
rm kafka_2.12-2.6.1.tgz

echo "update server.properties config..."
host=$(hostname)
subhost=${host:0-3}
sed -i "s/broker.id=0/broker.id=$subhost/g" kafka_2.12-2.6.1/config/server.properties
sed -i '/broker.id=/a\delete.topic.enable=true\n' kafka_2.12-2.6.1/config/server.properties
sed -i "s/log.dirs=\/tmp\/kafka-logs/log.dirs=\/opt\/module\/kafka_2.12-2.6.1\/logs/g" kafka_2.12-2.6.1/config/server.properties
sed -i "s/zookeeper.connect=localhost:2181/zookeeper.connect=hadoop101:2181,hadoop102:2181,hadoop103:2181/g" kafka_2.12-2.6.1/config/server.properties

echo "update /etc/profile..."
echo 'hadoop' | sudo -S sed -i '$aexport KAFKA_HOME=\/opt\/module\/kafka_2.12-2.6.1\nexport PATH=$PATH:$KAFKA_HOME\/bin' /etc/profile
source /etc/profile

echo "create logs folder..."
mkdir -p kafka_2.12-2.6.1/logs

echo "kafka installation finished!"
