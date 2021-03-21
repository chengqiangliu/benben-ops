#!/bin/bash

echo "preparing scala-2.12.13 installation..."
echo "checking if scala-2.12.13 is already installed and exit if it does..."
[ -d "/opt/module/scala-2.12.13" ] && exit 0

# move into /opt/module folder
cd /opt/module

# install scala-2.12.13
echo "Setting scala-2.12.13..."
echo "Untar scala-2.12.13 into /opt/module..."
sudo mv /tmp/tar/scala-2.12.13.tgz /opt/module/scala-2.12.13.tgz
echo "untar scala-2.12.13 ..."
sudo tar xvzf scala-2.12.13.tgz >/dev/null 2>&1
echo "removing scala-2.12.13 tar file..."
sudo rm /opt/module/scala-2.12.13.tgz
echo "granting required permissions to scala-2.12.13 folder..."
sudo chown -R root: scala-2.12.13
echo "making scala-2.12.13 available in the system..."
SCALA_HOME=/opt/module/scala-2.12.13
echo "export SCALA_HOME="$SCALA_HOME >>/etc/profile
echo "export PATH=\$PATH:\$SCALA_HOME/bin" >>/etc/profile
source /etc/profile
#sudo alternatives --install /usr/bin/scala scala /opt/module/scala-2.12.13/bin/scala 1

echo "Scala-2.12.13 installation finished!"