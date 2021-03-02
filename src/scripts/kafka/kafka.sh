#!/bin/bash
kafka_home=/opt/module/kafka_2.12-2.6.1
case $1 in
  "start") {
    for i in hadoop101 hadoop102 hadoop103
    do
      echo "==============$i 上 kafka 启动=============="
      ssh hadoop@$i "${kafka_home}/bin/kafka-server-start.sh -daemon ${kafka_home}/config/server.properties"
    done
  };;

  "stop") {
    for i in hadoop101 hadoop102 hadoop103
    do
      echo "==============$i 上 kafka 停止=============="
      ssh hadoop@$i "${kafka_home}/bin/kafka-server-stop.sh stop"
    done
  };;
esac