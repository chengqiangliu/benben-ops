#!/bin/bash

# move into /opt/module folder
cd /opt/module
mkdir -p /data/etcd/

echo "untar etcd-v3.4.15-linux-amd64.tar.gz ..."
tar zxvf etcd-v3.4.15-linux-amd64.tar.gz >/dev/null 2>&1
mkdir -p /opt/module/etcd/{bin,cfg,ssl}
mv etcd-v3.4.15-linux-amd64/{etcd,etcdctl} /opt/module/etcd/bin/
rm -rf etcd-v3.4.15-linux-amd64.tar.gz etcd-v3.4.15-linux-amd64

# 创建etcd配置文件
echo "create etcd config file ..."
host=$(hostname)
subhost=\${host:0-3}
cat > /opt/module/etcd/cfg/etcd.conf << EOF
#[Member]
ETCD_NAME="etcd-\${subhost}"
ETCD_DATA_DIR="/data/etcd/"
ETCD_LISTEN_PEER_URLS="https://192.168.10.\${subhost}:2380"
ETCD_LISTEN_CLIENT_URLS="https://192.168.10.\${subhost}:2379,http://127.0.0.1:2379"
#[Clustering]
ETCD_INITIAL_ADVERTISE_PEER_URLS="https://192.168.10.\${subhost}:2380"
ETCD_ADVERTISE_CLIENT_URLS="https://192.168.10.\${subhost}:2379"
ETCD_INITIAL_CLUSTER="etcd-101=https://192.168.10.101:2380, etcd-102=https://192.168.10.102:2380, etcd-103=https://192.168.10.103:2380"
ETCD_INITIAL_CLUSTER_TOKEN="etcd-cluster"
ETCD_INITIAL_CLUSTER_STATE="new"
EOF

# systemd管理etcd
echo "create etcd.service file ..."
cat > /usr/lib/systemd/system/etcd.service << EOF
[Unit]
Description=Etcd Server
After=network.target
After=network-online.target
Wants=network-online.target
Documentation=https://github.com/coreos
[Service]
Type=notify
WorkingDirectory=/data/etcd/
EnvironmentFile=-/opt/module/etcd/cfg/etcd.conf
ExecStart=/opt/module/etcd/bin/etcd \
--cert-file=/opt/module/etcd/ssl/kubernetes.pem \
--key-file=/opt/module/etcd/ssl/kubernetes-key.pem \
--peer-cert-file=/opt/module/etcd/ssl/kubernetes.pem \
--peer-key-file=/opt/module/etcd/ssl/kubernetes-key.pem \
--trusted-ca-file=/opt/module/etcd/ssl/ca.pem \
--peer-trusted-ca-file=/opt/module/etcd/ssl/ca.pem
Restart=on-failure
RestartSec=5
LimitNOFILE=65536
[Install]
WantedBy=multi-user.target
EOF

# 拷贝刚才生成的证书
echo "copy ceritficate file for etcd ..."
cp ~/TLS/k8s/ca*pem ~/TLS/k8s/kubernetes*pem /opt/module/etcd/ssl/

# 启动并设置开机启动
#echo "start etcd service ..."
systemctl daemon-reload
#systemctl start etcd
#systemctl enable etcd

