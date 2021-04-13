#!/bin/bash

# move into /opt/module folder
cd /opt/module

echo "start to install mysql ..."
echo 'hadoop' | sudo -S sudo yum localinstall -y mysql80-community-release-el7-3.noarch.rpm
echo 'hadoop' | sudo -S sudo yum install -y mysql-community-server
sudo chmod 777 /var/log/mysqld.log

sudo cat > /usr/lib/systemd/system/mysql.service << EOF
[Unit]
Description=MySQL Server
After=network.target

[Service]
ExecStart=/usr/sbin/mysqld --defaults-file=/etc/my.cnf --datadir=/var/lib/mysql User=mysql
Group=mysql
WorkingDirectory=/usr
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable mysql.service
sudo systemctl start mysql.service

# 1删除原来安装过的mysql残留的数据（这一步非常重要，问题就出在这）
#rm -rf /var/lib/mysql
# 2重启mysqld服务
#systemctl restart mysqld
# 3再去找临时密码
grep 'temporary password' /var/log/mysqld.log

# 修改密码
#mysql> ALTER USER 'root'@'localhost' IDENTIFIED BY '123456Aa!';


echo "mysql installation finished!"
