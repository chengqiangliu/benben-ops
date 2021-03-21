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

echo "Install docker..."
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum -y install docker-ce
systemctl enable docker && systemctl start docker
docker --version

# 安装 kubeadm，kubelet 和 kubectl
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

echo "Install kubelet kubeadm kubectl..."
yum install -y kubelet kubeadm kubectl
systemctl enable kubelet

# 部署 Kubernetes Master
kubeadm init \
--apiserver-advertise-address=192.168.10.101 \
--kubernetes-version v1.20.4 \
--service-cidr=10.96.0.0/12 \
--pod-network-cidr=10.244.0.0/16 \
--ignore-preflight-errors=all

# 使用 kubectl 工具
mkdir -p $HOME/.kube
  cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  chown $(id -u):$(id -g) $HOME/.kube/config
export KUBECONFIG=/etc/kubernetes/admin.conf

# 安装 Pod 网络插件(CNI)
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

# 加入 Kubernetes Node
kubeadm join 192.168.10.101:6443 --token k0bcgz.jcwxms292n6qgu1z \
 --discovery-token-ca-cert-hash sha256:372e26ea350655c9f69ce72804cbbc25db6d96f0c854cc7631e14c6aac88202f
