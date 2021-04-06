#!/bin/bash
es_home=/opt/module/elasticsearch-7.11.1

server_prefix='k8s'
case $1 in
  "start") {
    for i in ${server_prefix}101 ${server_prefix}102 ${server_prefix}103
    do
      echo "==============$i 上 ES 启动=============="
      ssh hadoop@$i "${es_home}/bin/elasticsearch >/dev/null 2>&1 &"
    done
  };;

  "stop") {
    for i in ${server_prefix}101 ${server_prefix}102 ${server_prefix}103
    do
      echo "==============$i 上 ES 停止=============="
      ssh hadoop@$i "ps -ef|grep $es_home | grep -v grep | awk '{print \$2}'| xargs kill" >/dev/null 2>&1
    done
  };;
esac