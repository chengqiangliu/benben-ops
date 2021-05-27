#!/bin/bash

mkdir -p /mydata/elasticsearch/config /mydata/elasticsearch/data /mydata/elasticsearch/plugins
echo "http.host: 0.0.0.0" >> /mydata/elasticsearch/config/elasticsearch.yml
chmod -R 777 /mydata/elasticsearch

docker run --name elasticsearch -p 9200:9200 -p 9300:9300 --restart always\
           -e "discovery.type=single-node" \
           -e ES_JAVA_OPTS="-Xms512m -Xmx1g" \
           -v /mydata/elasticsearch/config/elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml \
           -v /mydata/elasticsearch/data:/usr/share/elasticsearch/data \
           -v /mydata/elasticsearch/plugins:/usr/share/elasticsearch/plugins \
           -d elasticsearch:7.11.1

echo "elasticsearch installation finished!"
