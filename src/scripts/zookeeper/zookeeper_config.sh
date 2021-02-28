#!/bin/bash

# move into /opt/module folder
cd /opt/module

echo "untar zookeeper ..."
tar -xvzf apache-zookeeper-3.6.2-bin.tar.gz
mv apache-zookeeper-3.6.2-bin zookeeper-3.6.2

echo "removing apache-zookeeper-3.6.2-bin.tar.gz tar file..."
rm apache-zookeeper-3.6.2-bin.tar.gz

zookeeper_home=/opt/module/zookeeper-3.6.2
echo "update zoo.cfg file..."
mv $zookeeper_home/conf/zoo_sample.cfg $zookeeper_home/conf/zoo.cfg

sed -i "s/dataDir=\/tmp\/zookeeper/dataDir=\/opt\/module\/zookeeper-3.6.2\/zkData\//g" $zookeeper_home/conf/zoo.cfg


#./zkServer.sh start-foreground to debug the start log
# if get the following error, update ip of the current node in the zoo.cfg file to "0.0.0.0"
# 2021-02-27 21:16:18,030 [myid:2] - WARN  [QuorumConnectionThread-[myid=2]-2:QuorumCnxManager@400] - Cannot open channel to 3 at election address hadoop103/192.168.10.103:3888
# java.net.ConnectException: 拒绝连接 (Connection refused)
host=$(hostname)
case $host in
  "hadoop101") {
    # much use single quotes
    sed -i '$aserver.1=0.0.0.0:2888:3888\nserver.2=hadoop102:2888:3888\nserver.3=hadoop103:2888:3888\n' $zookeeper_home/conf/zoo.cfg
  };;

  "hadoop102") {
    sed -i '$aserver.1=hadoop101:2888:3888\nserver.2=0.0.0.0:2888:3888\nserver.3=hadoop103:2888:3888\n' $zookeeper_home/conf/zoo.cfg
  };;

 "hadoop103") {
    sed -i '$aserver.1=hadoop101:2888:3888\nserver.2=hadoop102:2888:3888\nserver.3=0.0.0.0:2888:3888\n' $zookeeper_home/conf/zoo.cfg
  };;
esac

echo "create zkData folder..."
mkdir -p $zookeeper_home/zkData

host=$(hostname)
subhost=${host:0-1}
echo $subhost > $zookeeper_home/zkData/myid

echo "zookeeper installation finished!"
