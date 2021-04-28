#!/bin/bash

echo "remove the installed docker ..."
echo 'hadoop' | sudo -S sudo yum remove docker \
                docker-client \
                docker-client-latest \
                docker-common \
                docker-latest \
                docker-latest-logrotate \
                docker-logrotate \
                docker-engine

echo "install docker ..."
sudo yum install -y yum-utils
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install -y docker-ce docker-ce-cli containerd.io

echo "start docker and make it run from PC start ..."
echo 'hadoop' | sudo -S systemctl start docker
echo 'hadoop' | sudo -S systemctl enable docker

echo "give the docker access to the user who is not root user ..."
sudo groupadd docker
sudo usermod -aG docker ${USER}
newgrp docker
