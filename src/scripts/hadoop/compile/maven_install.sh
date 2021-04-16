#!/bin/bash

echo "preparing Maven installation..."
echo "checking if maven is already installed and exit if it does..."
[ -d "/opt/module/apache-maven-3.8.1" ] && exit 0

# move into /opt/module folder
cd /opt/module

# install maven
echo "Untar maven into /opt/module..."
tar -zxvf apache-maven-3.8.1-bin.tar.gz >/dev/null 2>&1
echo "removing apache-maven-3.8.1-bin.tar.gz tar file..."
sudo rm /opt/module/apache-maven-3.8.1-bin.tar.gz
echo "making apache-maven-3.8.1 available in the system..."
MAVEN_HOME=/opt/module/apache-maven-3.8.1
echo "export MAVEN_HOME="$MAVEN_HOME >>/etc/profile
echo "export PATH=\$PATH:\$MAVEN_HOME/bin" >>/etc/profile
source /etc/profile

mvn -version
echo "Maven installation finished!"