#!/bin/bash

server_prefix='k8s'
scp src/tar/helm-v3.5.3-linux-amd64.tar.gz root@${server_prefix}101:/opt/module
scp src/scripts/helm/helm_config.sh root@${server_prefix}101:/root
ssh root@${server_prefix}101 '/root/helm_config.sh'
