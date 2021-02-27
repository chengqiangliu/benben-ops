#!/bin/bash

echo "preparing JDK 8 installation..."
echo "checking if jdk 1.8.0_281 is already installed and exit if it does..."
[ -d "/opt/module/jdk1.8.0_281" ] && exit 0

# move into /opt/module folder
cd /opt/module

# install JDK 8
echo "Setting JDK 8..."
echo "Untar JDK 8 into /opt/module..."
sudo mv /tmp/tar/jdk-8u281-linux-x64.tar.gz /opt/module/jdk-8u281-linux-x64.tar.gz
echo "untar jdk 1.8.0_281 ..."
sudo tar xvzf jdk-8u281-linux-x64.tar.gz
echo "removing jdk-8u281-linux-x64.tar.gz tar file..."
sudo rm /opt/module/jdk-8u281-linux-x64.tar.gz
echo "granting required permissions to jdk1.8.0_281 folder..."
sudo chown -R root: jdk1.8.0_281
echo "making jdk 1.8.0_281 available in the system..."
sudo alternatives --install /usr/bin/java java /opt/module/jdk1.8.0_281/bin/java 1

echo "Java 8 installation finished!"