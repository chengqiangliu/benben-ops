#!/bin/bash

docker run --name kibana -p 5601:5601 --restart always\
           -e ELASTICSEARCH_HOSTS="http://192.168.10.201:9200" \
           -d kibana:7.11.1

echo "kibana installation finished!"
