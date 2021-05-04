#!/bin/bash

# move into /opt/module folder
cd /opt/module

echo "untar nacos ..."
tar -xvzf nacos-server-2.0.0.tar.gz

echo "removing nacos-server-2.0.0.tar.gz tar file..."
rm nacos-server-2.0.0.tar.gz

./nacos/bin/startup.sh -m standalone
