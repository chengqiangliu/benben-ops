#!/bin/bash

server_prefix='k8s'
for((host=111; host<=113; host++)); do
  ssh hadoop@$server_prefix$host 'echo -e "\n"|ssh-keygen -t rsa -N ""'
  ssh root@$server_prefix$host 'echo -e "\n"|ssh-keygen -t rsa -N ""'
done

