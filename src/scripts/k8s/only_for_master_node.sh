#!/bin/bash

# 部署 Kubernetes Master
kubeadm init \
--apiserver-advertise-address=192.168.10.111 \
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
