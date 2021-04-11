#!/bin/bash

#sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
#sudo systemctl restart sshd

# edit host file
server_prefix='k8s'
sudo sh -c "echo 192.168.10.111 ${server_prefix}201 >> /etc/hosts"
sudo sh -c "echo 192.168.10.112 ${server_prefix}202 >> /etc/hosts"
sudo sh -c "echo 192.168.10.113 ${server_prefix}203 >> /etc/hosts"

sudo ntpdate time.windows.com

echo "Initial script finished!"