#!/bin/bash

server_prefix='k8s'
username=root
for((host=101; host<=103; host++)); do
  ssh $username@$server_prefix$host 'echo -e "\n"|ssh-keygen -t rsa -N ""'
done

