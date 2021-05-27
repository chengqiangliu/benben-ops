#!/bin/bash

# move into /opt/module folder
cd /opt/module

echo "untar kibana ..."
tar -xvzf kibana-7.11.1-linux-x86_64.tar.gz
mv kibana-7.11.1-linux-x86_64 kibana-7.11.1

echo "removing kibana-7.11.1-linux-x86_64.tar.gz tar file..."
rm kibana-7.11.1-linux-x86_64.tar.gz

echo "update kibana.yml config..."
sed -i "s/#server.host: \"localhost\"/server.host: \"0.0.0.0\"/g" kibana-7.11.1/config/kibana.yml
sed -i "s/#elasticsearch.hosts: \[\"http:\/\/localhost:9200\"\]/elasticsearch.hosts: \[\"http:\/\/hadoop101:9200\", \"http:\/\/hadoop102:9200\", \"http:\/\/hadoop103:9200\"\]/g" kibana-7.11.1/config/kibana.yml

echo "create logs folder..."
mkdir -p kibana-7.11.1/logs

echo "kibana installation finished!"
