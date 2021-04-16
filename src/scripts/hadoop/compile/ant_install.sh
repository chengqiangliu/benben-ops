#!/bin/bash

echo "preparing Ant installation..."
echo "checking if Ant is already installed and exit if it does..."
[ -d "/opt/module/apache-ant-1.9.15" ] && exit 0

# move into /opt/module folder
cd /opt/module

# install Ant
echo "Untar Ant into /opt/module..."
tar -zxvf apache-ant-1.9.15-bin.tar.gz >/dev/null 2>&1
echo "removing apache-ant-1.9.15-bin.tar.gz tar file..."
sudo rm /opt/module/apache-ant-1.9.15-bin.tar.gz
echo "making apache-ant-1.9.15 available in the system..."
ANT_HOME=/opt/module/apache-ant-1.9.15
echo "export ANT_HOME="$ANT_HOME >>/etc/profile
echo "export PATH=\$PATH:\$ANT_HOME/bin" >>/etc/profile
source /etc/profile

ant -version
echo "Ant installation finished!"