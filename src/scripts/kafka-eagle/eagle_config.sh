#!/bin/bash

# move into /opt/module folder
cd /opt/module

echo "untar kafka-eagle ..."
tar -xvzf kafka-eagle-bin-2.0.4.tar.gz >/dev/null 2>&1
cd kafka-eagle-bin-2.0.4
tar -xvzf kafka-eagle-web-2.0.4-bin.tar.gz -C /opt/module >/dev/null 2>&1
cd /opt/module
mv kafka-eagle-web-2.0.4 kafka-eagle

echo "removing kafka-eagle-bin-2.0.4.tar.gz tar file..."
rm -rf kafka-eagle-bin-2.0.4.tar.gz kafka-eagle-bin-2.0.4

echo "update system-config.properties config..."
sed -i "s/kafka.eagle.zk.cluster.alias=cluster1,cluster2/kafka.eagle.zk.cluster.alias=cluster1/g" kafka-eagle/conf/system-config.properties
sed -i "s/cluster1.zk.list=tdn1:2181,tdn2:2181,tdn3:2181/cluster1.zk.list=hadoop101:2181,hadoop102:2181,hadoop103:2181/g" kafka-eagle/conf/system-config.properties
sed -i "s/cluster2.zk.list=/#cluster2.zk.list=/g" kafka-eagle/conf/system-config.properties
sed -i "s/cluster2.kafka.eagle.offset.storage=zk/#cluster2.kafka.eagle.offset.storage=zk/g" kafka-eagle/conf/system-config.properties
sed -i '/sqlite[[:space:]]jdbc/,+7d' kafka-eagle/conf/system-config.properties
sed -i "s/#kafka.eagle.driver/kafka.eagle.driver/g" kafka-eagle/conf/system-config.properties
sed -i "s/#kafka.eagle.url/kafka.eagle.url/g" kafka-eagle/conf/system-config.properties
sed -i "s/#kafka.eagle.username/kafka.eagle.username/g" kafka-eagle/conf/system-config.properties
sed -i "s/#kafka.eagle.password=123456/kafka.eagle.password=R@kuten1024/g" kafka-eagle/conf/system-config.properties

echo "update /etc/profile config..."
KE_HOME=/opt/module/kafka-eagle
echo 'hadoop' | sudo -S sed -i '$aexport KE_HOME='"${KE_HOME}"'\nexport PATH=\$PATH:\$KE_HOME\/bin' /etc/profile
source /etc/profile
echo "kafka-eagle installation finished!"

echo "start kafka-eagle ..."
kafka-eagle/bin/ke.sh start


