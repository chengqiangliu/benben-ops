#!/bin/bash

echo "Updating system..."
sudo yum update -y

echo "Install some useful tools..."
sudo yum install -y wget net-tools ntp

sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo systemctl restart sshd

sudo useradd -m -d /home/hadoop -s /bin/bash hadoop
echo -e "hadoop\nhadoop\n" | sudo passwd hadoop
sudo chmod 700 -R /home/hadoop/
sudo usermod -aG wheel hadoop
sudo mkdir -p /opt/module /home/hadoop/bin
sudo chown hadoop:hadoop /opt/module/ /home/hadoop/bin

# edit host file
server_prefix='k8s'
sudo sh -c "echo 192.168.10.101 ${server_prefix}101 >> /etc/hosts"
sudo sh -c "echo 192.168.10.102 ${server_prefix}102 >> /etc/hosts"
sudo sh -c "echo 192.168.10.103 ${server_prefix}103 >> /etc/hosts"

echo "Initial script finished!"