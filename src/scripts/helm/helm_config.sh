#!/bin/bash

# move into /opt/module folder
cd /opt/module

echo "untar helm ..."
tar -xvzf helm-v3.5.3-linux-amd64.tar.gz

echo "removing helm-v3.5.3-linux-amd64.tar.gz file..."
rm helm-v3.5.3-linux-amd64.tar.gz

echo "move helm to /usr/bin/..."
mv linux-amd64/helm /usr/bin/
rm -rf linux-amd64

echo "install helm and kubectl completion..."
yum install -y bash-completion
source /usr/share/bash-completion/bash_completion
source <(helm completion bash)

echo "helm installation finished!"
