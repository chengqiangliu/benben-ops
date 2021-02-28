#!/bin/bash
kibana_home=/opt/module/kibana-7.11.1
host=hadoop101
case $1 in
  "start") {
    echo "==============$host 上 kibana 启动=============="
    ssh hadoop@$host "nohup $kibana_home/bin/kibana >${kibana_home}/logs/kibana.log 2>&1 &"
  };;

  "stop") {
    echo "==============$host 上 kibana 停止=============="
    ssh hadoop@$host "ps -ef|grep $kibana_home | grep -v grep | awk '{print \$2}'| xargs kill" >/dev/null 2>&1
  };;
esac