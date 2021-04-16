#!/bin/bash

# move into /opt/module folder
cd /opt/module

echo "untar kafka ..."
tar -xvzf kafka_2.12-2.6.1.tgz >/dev/null 2>&1

echo "removing kafka_2.12-2.6.1.tgz tar file..."
rm kafka_2.12-2.6.1.tgz

echo "update server.properties config..."
host=$(hostname)
subhost=${host:0-3}
sed -i "s/broker.id=0/broker.id=$subhost/g" kafka_2.12-2.6.1/config/server.properties
sed -i '/broker.id=/a\delete.topic.enable=true\n' kafka_2.12-2.6.1/config/server.properties
sed -i "s/log.dirs=\/tmp\/kafka-logs/log.dirs=\/opt\/module\/kafka_2.12-2.6.1\/data/g" kafka_2.12-2.6.1/config/server.properties
sed -i "s/zookeeper.connect=localhost:2181/zookeeper.connect=hadoop101:2181,hadoop102:2181,hadoop103:2181/g" kafka_2.12-2.6.1/config/server.properties

echo "update /etc/profile..."
echo 'hadoop' | sudo -S sed -i '$aexport KAFKA_HOME=\/opt\/module\/kafka_2.12-2.6.1\nexport PATH=$PATH:$KAFKA_HOME\/bin' /etc/profile
source /etc/profile

echo "create logs folder..."
mkdir -p kafka_2.12-2.6.1/logs

sed -i "s/export KAFKA_HEAP_OPTS=\"-Xmx1G -Xms1G\"/#export KAFKA_HEAP_OPTS=\"-Xmx1G -Xms1G\"/g" kafka_2.12-2.6.1/bin/kafka-server-start.sh
sed -i "/#export KAFKA_HEAP_OPTS=/a\    export KAFKA_HEAP_OPTS=\"-server -Xms2G -Xmx2G -XX:PermSize=128m -XX:+UseG1GC -XX:MaxGCPauseMillis=200 -XX:ParallelGCThreads=8 -XX:ConcGCThreads=5 -XX:InitiatingHeapOccupancyPercent=70\"\n    export JMX_PORT=\"9999\"" kafka_2.12-2.6.1/bin/kafka-server-start.sh

echo "kafka installation finished!"
