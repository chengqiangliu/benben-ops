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

# 给用户root权限
# 方法一：在下面这行下面加上一行新的
# root	ALL=(ALL) 	ALL
# hadoop	ALL=(ALL) 	ALL

# 方法二：运行下面这条命令
# sudo usermod -aG wheel hadoop

# 确保/etc/sudoers中此行： %wheel  ALL=(ALL)     ALL    没有被注释
# sudo su -    //虽然Hadoop没有管理的密码，但是利用此命令依然可以切换到管理员

sudo usermod -aG wheel hadoop
sudo mkdir -p /opt/module /home/hadoop/bin
sudo chown hadoop:hadoop /opt/module/ /home/hadoop/bin

# edit host file
#server_prefix='hadoop'
#sudo sh -c "echo 192.168.10.101 ${server_prefix}101 >> /etc/hosts"
#sudo sh -c "echo 192.168.10.102 ${server_prefix}102 >> /etc/hosts"
#sudo sh -c "echo 192.168.10.103 ${server_prefix}103 >> /etc/hosts"

echo "Initial script finished!"