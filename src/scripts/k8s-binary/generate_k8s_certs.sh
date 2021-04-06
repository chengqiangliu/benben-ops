#!/bin/bash

# 自签证书颁发机构(CA)
mkdir -p ~/TLS/k8s
cd ~/TLS/k8s

cat > ca-config.json<< EOF
{
  "signing": {
    "default": {
      "expiry": "87600h"
    },
    "profiles": {
      "kubernetes": {
        "usages": [
          "signing",
          "key encipherment",
          "server auth",
          "client auth"
        ],
        "expiry": "87600h"
      }
    }
  }
}
EOF

cat > ca-csr.json<< EOF
{
  "CN": "kubernetes",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "CN",
      "ST": "BeiJing",
      "L": "BeiJing",
      "O": "k8s",
      "OU": "System"
    }
  ],
  "ca": {
    "expiry": "87600h"
  }
}
EOF

cfssl gencert -initca ca-csr.json | cfssljson -bare ca
ls ca*

# 创建etcd证书申请文件
#cat > etcd-csr.json<< EOF
#{
#  "CN": "etcd",
#  "hosts": [
#    "192.168.10.101",
#    "192.168.10.102",
#    "192.168.10.103"
#  ],
#  "key": {
#    "algo": "rsa",
#    "size": 2048
#  },
#  "names": [
#    {
#      "C": "CN",
#      "ST": "BeiJing",
#      "L": "BeiJing",
#      "O": "k8s",
#      "OU": "System"
#    }
#  ],
#}
#EOF

# 创建kube-apiserver证书申请文件
cat > kubernetes-csr.json<< EOF
{
  "CN": "kubernetes",
  "hosts": [
    "10.0.0.1",
    "127.0.0.1",
    "192.168.10.101",
    "192.168.10.101",
    "192.168.10.101",
    "10.254.0.1",
    "192.168.10.1/24",
    "kubernetes",
    "kube-api.wangdong.com",
    "kubernetes.default",
    "kubernetes.default.svc",
    "kubernetes.default.svc.cluster",
    "kubernetes.default.svc.cluster.local"
  ],
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "CN",
      "ST": "BeiJing",
      "L": "BeiJing",
      "O": "k8s",
      "OU": "System"
    }
  ]
}
EOF

cat > admin-csr.json <<EOF
{
  "CN": "admin",
  "hosts": [],
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "CN",
      "ST": "BeiJing",
      "L": "BeiJing",
      "O": "system:masters",
      "OU": "System"
    }
  ]
}
EOF

cat > kube-proxy-csr.json <<EOF
{
  "CN": "system:kube-proxy",
  "hosts": [],
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "CN",
      "ST": "BeiJing",
      "L": "BeiJing",
      "O": "k8s",
      "OU": "System"
    }
  ]
}
EOF

#cat > service-account-csr.json <<EOF
#{
#  "CN": "service-accounts",
#  "key": {
#    "algo": "rsa",
#    "size": 2048
#  },
#  "names": [
#    {
#      "C": "JP",
#      "L": "Tokyo",
#      "ST": "Tokyo",
#      "O": "Kubernetes",
#      "OU": "System"
#    }
#  ]
#}
#EOF

# 使用自签 CA 签发证书
#cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=kubernetes etcd-csr.json | cfssljson -bare etcd
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=kubernetes kubernetes-csr.json | cfssljson -bare kubernetes
#cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=kubernetes service-account-csr.json | cfssljson -bare service-account
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=kubernetes admin-csr.json | cfssljson -bare admin
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=kubernetes kube-proxy-csr.json | cfssljson -bare kube-proxy
rm -rf *.json *.csr
ls

# copy到其他server
xsync ~/TLS/k8s
