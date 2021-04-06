#!/bin/bash

server_prefix='k8s'

#scp src/scripts/k8s-binary/ssl_tool_download.sh root@${server_prefix}101:/root
#scp src/scripts/k8s-binary/generate_k8s_certs.sh root@${server_prefix}101:/root
#ssh root@${server_prefix}101 '/root/ssl_tool_download.sh'
#ssh root@${server_prefix}101 '/root/generate_k8s_certs.sh'

for((host=101; host<=103; host++)); do
#  scp src/scripts/k8s-binary/cluster_init_config.sh root@${server_prefix}${host}:/root
#  ssh root@${server_prefix}${host} '/root/cluster_init_config.sh'
  scp src/tar/etcd-v3.4.15-linux-amd64.tar.gz root@${server_prefix}${host}:/opt/module
  scp src/scripts/k8s-binary/etcd_cluster_setup.sh root@${server_prefix}${host}:/root
  ssh root@${server_prefix}${host} '/root/etcd_cluster_setup.sh'
done

# deploy k8s master node
#scp src/tar/kubernetes-server-linux-amd64.tar.gz root@${server_prefix}101:/opt/module
#scp src/scripts/k8s-binary/k8s_master_node_setup.sh root@${server_prefix}101:/root
#ssh root@${server_prefix}101 '/root/k8s_master_node_setup.sh'
