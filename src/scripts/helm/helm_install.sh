#!/bin/bash

scp src/tar/helm-v3.5.3-linux-amd64.tar.gz root@hadoop101:/opt/module
scp src/scripts/helm/helm_config.sh root@hadoop101:/root
ssh root@hadoop101 '/root/helm_config.sh'
