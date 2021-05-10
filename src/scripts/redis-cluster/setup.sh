#!/bin/bash

for port in $(seq 7001 7006); do
mkdir -p /mydata/redis/node-${port}/conf /mydata/redis/node-${port}/data
cat << EOF > /mydata/redis/node-${port}/conf/redis.conf
  port ${port}
  cluster-enabled yes
  cluster-config-file nodes.conf
  cluster-node-timeout 5000
  cluster-announce-ip 192.168.10.201
  cluster-announce-port ${port}
  cluster-announce-bus-port 1${port}
EOF

  docker run -p ${port}:${port} -p 1${port}:1${port} --name redis-${port} \
             -v /mydata/redis/node-${port}/data:/data \
             -v /mydata/redis/node-${port}/conf/redis.conf:/etc/redis/redis.conf \
             -d redis:6.2.3 redis-server /etc/redis/redis.conf
done