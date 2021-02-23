#!/bin/bash

echo "Updating system..."
sudo yum update -y

sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo systemctl restart sshd

sudo useradd -m -d /home/hadoop -s /bin/bash hadoop
echo -e "hadoop\nhadoop\n" | sudo passwd hadoop
sudo chmod 700 -R /home/hadoop/
sudo usermod -aG wheel hadoop

# edit host file
sudo sh -c "echo 192.168.10.101 hadoop101 >> /etc/hosts"
sudo sh -c "echo 192.168.10.102 hadoop102 >> /etc/hosts"
sudo sh -c "echo 192.168.10.103 hadoop103 >> /etc/hosts"

echo "Initial script finished!"