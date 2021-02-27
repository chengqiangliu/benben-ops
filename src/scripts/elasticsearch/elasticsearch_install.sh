#!/bin/bash

# move into /opt/module folder
cd /opt/module

echo "untar elasticsearch ..."
tar -xvzf elasticsearch-7.11.1-linux-x86_64.tar.gz

echo "removing elasticsearch-7.11.1-linux-x86_64.tar.gz tar file..."
rm elasticsearch-7.11.1-linux-x86_64.tar.gz

host=$(hostname)
subhost=${host:0-3}
echo "update elasticsearch.yml config..."
sed -i "s/#cluster.name: my-application/cluster.name: benben-es/g" elasticsearch-7.11.1/config/elasticsearch.yml
sed -i "s/#node.name: node-1/node.name: node-${subhost}/g" elasticsearch-7.11.1/config/elasticsearch.yml
sed -i "s/#bootstrap.memory_lock: true/bootstrap.memory_lock: false/g" elasticsearch-7.11.1/config/elasticsearch.yml
sed -i "/bootstrap.memory_lock: false/a\bootstrap.system_call_filter: false" elasticsearch-7.11.1/config/elasticsearch.yml
sed -i "s/#network.host: 192.168.0.1/network.host: ${host}/g" elasticsearch-7.11.1/config/elasticsearch.yml
sed -i "s/#discovery.seed_hosts: \[\"host1\", \"host2\"\]/discovery.seed_hosts: \[\"hadoop101\", \"hadoop102\", \"hadoop103\"\]/g" elasticsearch-7.11.1/config/elasticsearch.yml
sed -i "s/#cluster.initial_master_nodes: \[\"node-1\", \"node-2\"\]/cluster.initial_master_nodes: \[\"node-101\", \"node-102\", \"node-103\"\]/g" elasticsearch-7.11.1/config/elasticsearch.yml

echo "update jvm.options config..."
sed -i "s/## -Xms4g/-Xms512m/g" elasticsearch-7.11.1/config/jvm.options
sed -i "s/## -Xmx4g/-Xmx512m/g" elasticsearch-7.11.1/config/jvm.options

# to resolve the issue: max file descriptors [4096] for elasticsearch process is too low, increase to at least [65535]
echo 'hadoop' | sudo -S sudo sed -i '/# End of file/i\* soft nofile 65536\n* hard nofile 131072\n* soft nproc 2048\n* hard nproc 65536\n' /etc/security/limits.conf

# to resolve the issue: max number of threads [3902] for user [hadoop] is too low, increase to at least [4096]
echo 'hadoop' | sudo -S sudo sed -i "s/*          soft    nproc     1024/*          soft    nproc     4096/g" /etc/security/limits.d/20-nproc.conf


# to resolve the issue: max virtual memory areas vm.max_map_count [65530] is too low, increase to at least [262144]
echo 'hadoop' | sudo -S sed -i '$avm.max_map_count=262144' /etc/sysctl.conf

echo "elasticsearch installation finished!"