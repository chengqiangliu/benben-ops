#!/bin/bash

for((host=101; host<=103; host++)); do
  ssh root@hadoop$host 'echo -e "\n"|ssh-keygen -t rsa -N ""'
done

