#!/bin/bash

# 关闭防火墙
echo "关闭防火墙..."
systemctl stop firewalld
systemctl disable firewalld

# 关闭 selinux
echo "关闭selinux..."
# 永久
sed -i 's/enforcing/disabled/' /etc/selinux/config
# 临时
setenforce 0

# 关闭 swap
echo "关闭swap..."
# 临时
swapoff -a
# 永久
sed -i 's/\/swapfile none swap defaults 0 0/#\/swapfile none swap defaults 0 0/' /etc/fstab

# 将桥接的 IPv4 流量传递到 iptables 的链
echo "将桥接的 IPv4 流量传递到 iptables 的链..."
cat > /etc/sysctl.d/k8s.conf << EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

# 生效
sysctl --system

# 时间同步
yum install ntpdate -y
ntpdate time.windows.com

echo "Install docker..."
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum -y install docker-ce
systemctl enable docker && systemctl start docker
docker --version
