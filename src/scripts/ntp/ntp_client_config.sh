#!/bin/bash

result=$(rpm -qa | grep ntp)
if [[ ! $result  ]]; then
  echo "ntp was not installed, start to install ..."
  yum install -y ntp
else
  echo "ntp has bee installed"
fi

echo "update /etc/ntp.conf file ..."

# 修改server节点
sed -i "/restrict ::1/a\server 192.168.10.101" /etc/ntp.conf

# 允许上层时间服务器主动修改本机时间
sed -i "s/#restrict 192.168.1.0 mask 255.255.255.0 nomodify notrap/restrict 192.168.10.101 nomodify notrap noquery/g" /etc/ntp.conf

# 集群在局域网中，不使用其他互联网上的时间
sed -i "s/server 0.centos.pool.ntp.org iburst/#server 0.centos.pool.ntp.org iburst/g" /etc/ntp.conf
sed -i "s/server 1.centos.pool.ntp.org iburst/#server 1.centos.pool.ntp.org iburst/g" /etc/ntp.conf
sed -i "s/server 2.centos.pool.ntp.org iburst/#server 2.centos.pool.ntp.org iburst/g" /etc/ntp.conf
sed -i "s/server 3.centos.pool.ntp.org iburst/#server 3.centos.pool.ntp.org iburst/g" /etc/ntp.conf

# 外部时间服务器不可用时，以本地时间作为时间服务
sed -i '$ae#外部时间服务器不可用时，以本地时间作为时间服务\nserver 127.0.0.1\nfudge 127.0.0.1 stratum 10' /etc/ntp.conf

echo "update /etc/sysconfig/ntpd file ..."
# 让硬件时间与系统时间一起同步
sed -i '$aYNC_HWCLOCK=yes' /etc/sysconfig/ntpd

echo "start ntp service ..."

# 启动NTP服务
systemctl start ntpd

echo "enalbe ntp from power up ..."

#将NTP服务设置为开机启动
systemctl enable ntpd
