#!/bin/bash

## Hadoop配置文件
# 核心配置文件
# core-site.xml

# HDFS配置文件
# hadoop-env.sh
# hdfs-site.xml

#YARN配置文件
# yarn-env.sh
# yarn-site.xml

# MapReduce配置文件
# mapred-env.sh
# mapred-site.xml

# web端查看HDFS文件系统
# http://hadoop101:50070/dfshealth.html#tab-overview
# Web端查看SecondaryNameNode
# http://hadoop103:50090/status.html
# YARN的浏览器页面查看
# http://hadoop102:8088/cluster
# 查看JobHistory
# http://hadoop101:19888/jobhistory

# 如果datanode显示不出来，而且在datanode的log显示下面的error
# org.apache.hadoop.hdfs.server.datanode.DataNode: Problem connecting to server: hadoop101/192.168.10.101:9000
# 把/etc/hosts改成即可
# [hadoop@hadoop101 sbin]$ cat /etc/hosts
# 127.0.0.1  localhost.localdomain  localhost
# 192.168.10.101 hadoop101
# 192.168.10.102 hadoop102
# 192.168.10.103 hadoop103

for((host=101; host<=103; host++)); do
  scp src/tar/hadoop-2.9.2.tar.gz hadoop@hadoop${host}:/opt/module
  scp src/scripts/hadoop/hadoop_config.sh hadoop@hadoop${host}:/home/hadoop/bin
  ssh hadoop@hadoop${host} '/home/hadoop/bin/hadoop_config.sh'

  scp src/scripts/hadoop/config/* hadoop@hadoop${host}:/opt/module/hadoop-2.9.2/etc/hadoop
done

