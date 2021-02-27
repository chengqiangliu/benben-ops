#!/bin/bash

echo "checking if xsync is already installed and exit if it does..."
[ -f "/home/hadoop/bin/xsync" ] && exit 0

# move into /home/hadoop/bin folder
cd /home/hadoop/bin

# install JDK 8
echo "Copy xsync..."
sudo mv /tmp/xsync /home/hadoop/bin/xsync
echo "granting required permissions to xsync..."
sudo chmod 777 /home/hadoop/bin/xsync
sudo chown hadoop:hadoop /home/hadoop/bin/xsync

echo "xsync installation finished!"