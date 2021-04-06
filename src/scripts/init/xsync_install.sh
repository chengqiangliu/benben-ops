#!/bin/bash

echo "checking if xsync is already installed and exit if it does..."
[ -f "~/bin/xsync" ] && exit 0
mkdir -p ~/bin/

# move into ~/bin folder
cd ~/bin

# install xsync
echo "Copy xsync..."
sudo mv /tmp/xsync ~/bin/xsync
echo "granting required permissions to xsync..."
sudo chmod 777 ~/bin/xsync
#sudo chown hadoop:hadoop ~/bin/xsync

echo "xsync installation finished!"