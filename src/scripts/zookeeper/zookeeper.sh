#!/bin/bash
zookeeper_home=/opt/module/zookeeper-3.6.2
case $1 in
  "start") {
    for i in hadoop101 hadoop102 hadoop103
    do
      echo "==============$i 上 zookeeper 启动=============="
      ssh hadoop@$i "/opt/module/zookeeper-3.6.2/bin/zkServer.sh start"
    done
  };;

  "stop") {
    for i in hadoop101 hadoop102 hadoop103
    do
      echo "==============$i 上 zookeeper 停止=============="
      ssh hadoop@$i "${zookeeper_home}/bin/zkServer.sh stop"
    done
  };;

  "status") {
    for i in hadoop101 hadoop102 hadoop103
    do
      echo "==============$i 上 zookeeper 停止=============="
      ssh hadoop@$i "${zookeeper_home}/bin/zkServer.sh status"
    done
  };;
esac