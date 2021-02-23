#!/bin/bash

echo "preparing scala-2.12.13 installation..."
echo "checking if scala-2.12.13 is already installed and exit if it does..."
[ -d "/opt/scala-2.12.13" ] && exit 0

# move into opt folder
cd /opt/

# install scala-2.12.13
echo "Setting scala-2.12.13..."
echo "Untar scala-2.12.13 into /opt/..."
sudo mv /tmp/tar/scala-2.12.13.tgz /opt/scala-2.12.13.tgz
echo "untar scala-2.12.13 ..."
sudo tar xvzf scala-2.12.13.tgz
echo "removing scala-2.12.13 tar file..."
sudo rm /opt/scala-2.12.13.tgz
echo "granting required permissions to scala-2.12.13 folder..."
sudo chown -R root: scala-2.12.13
echo "making scala-2.12.13 available in the system..."
sudo alternatives --install /usr/bin/scala scala /opt/scala-2.12.13/bin/scala 1

echo "Scala-2.12.13 installation finished!"