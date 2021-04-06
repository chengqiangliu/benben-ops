#!/bin/bash

# move into /opt/module folder
cd /opt/module

echo "untar kubernetes-server-linux-amd64.tar.gz ..."
tar zxvf kubernetes-server-linux-amd64.tar.gz >/dev/null 2>&1
mkdir -p /opt/module/kubernetes/{bin,cfg,ssl,logs}
cd kubernetes/server/bin
cp kube-apiserver kube-scheduler kube-controller-manager /opt/module/kubernetes/bin
cp kubectl /usr/bin/
rm -rf /opt/module/kubernetes-server-linux-amd64.tar.gz

# 创建etcd配置文件
echo "create apiserver config file ..."
cat > /opt/module/kubernetes/cfg/kube-apiserver.conf << EOF
KUBE_APISERVER_OPTS="--logtostderr=false \\
--v=2 \\
--log-dir=/opt/module/kubernetes/logs \\
--etcd-servers=https://192.168.10.101:2379,https://192.168.10.102:2379,https://192.168.10.103:2379 \\
--bind-address=192.168.10.101 \\
--secure-port=6443 \\
--advertise-address=192.168.10.101 \\
--allow-privileged=true \\
--service-cluster-ip-range=10.0.0.0/24 \\
--enable-admission-plugins=NamespaceLifecycle,LimitRanger,ServiceAccount,ResourceQuota,NodeRestriction \\
--authorization-mode=RBAC,Node \\
--enable-bootstrap-token-auth=true \\
--token-auth-file=/opt/module/kubernetes/cfg/token.csv \\
--service-node-port-range=30000-32767 \\
--service-account-key-file=/opt/module/kubernetes/ssl/ca-key.pem \\
--service-account-signing-key-file=/opt/module/kubernetes/ssl/server-key.pem \\
--service-account-issuer=api \\
--kubelet-client-certificate=/opt/module/kubernetes/ssl/server.pem \\
--kubelet-client-key=/opt/module/kubernetes/ssl/server-key.pem \\
--tls-cert-file=/opt/module/kubernetes/ssl/server.pem \\
--tls-private-key-file=/opt/module/kubernetes/ssl/server-key.pem \\
--client-ca-file=/opt/module/kubernetes/ssl/ca.pem \\
--etcd-cafile=/opt/module/etcd/ssl/ca.pem \\
--etcd-certfile=/opt/module/etcd/ssl/server.pem \\
--etcd-keyfile=/opt/module/etcd/ssl/server-key.pem \\
--audit-log-maxage=30 \\
--audit-log-maxbackup=3 \\
--audit-log-maxsize=100 \\
--audit-log-path=/opt/module/kubernetes/logs/k8s-audit.log"
EOF

# 拷贝刚才生成的证书
echo "copy ceritficate file for k8s api server ..."
cp ~/TLS/k8s/ca*pem ~/TLS/k8s/server*pem /opt/module/kubernetes/ssl/

echo "generate apiserver token file ..."
# head -c 16 /dev/urandom | od -An -t x | tr -d ' ' to generate token
cat > /opt/module/kubernetes/cfg/token.csv << EOF
069de1b0cf5df84ace230c875662dff2,kubelet-bootstrap,10001,"system:node-bootstrapper"
EOF

# systemd 管理 apiserver
echo "make apiserver be managed by systemd ..."
cat > /usr/lib/systemd/system/kube-apiserver.service << EOF
[Unit]
Description=Kubernetes API Server
Documentation=https://github.com/kubernetes/kubernetes
[Service]
EnvironmentFile=/opt/module/kubernetes/cfg/kube-apiserver.conf
ExecStart=/opt/module/kubernetes/bin/kube-apiserver \$KUBE_APISERVER_OPTS
Restart=on-failure
[Install]
WantedBy=multi-user.target
EOF

# 启动并设置开机启动
# if start failed to check the detail error message with the command: journalctl -xe -u kube-apiserver
echo "start apiserver service ..."
systemctl daemon-reload
systemctl start kube-apiserver
systemctl enable kube-apiserver

## 授权 kubelet-bootstrap 用户允许请求证书
#kubectl create clusterrolebinding kubelet-bootstrap \
#--clusterrole=system:node-bootstrapper \
#--user=kubelet-bootstrap

# 创建kube-controller-manager配置文件
echo "create controller-manager config file ..."
cat > /opt/module/kubernetes/cfg/kube-controller-manager.conf << EOF
KUBE_CONTROLLER_MANAGER_OPTS="--logtostderr=false \\
--v=2 \\
--log-dir=/opt/module/kubernetes/logs \\
--leader-elect=true \\
--master=127.0.0.1:8080 \\
--bind-address=127.0.0.1 \\
--allocate-node-cidrs=true \\
--cluster-cidr=10.244.0.0/16 \\
--service-cluster-ip-range=10.0.0.0/24 \\
--cluster-signing-cert-file=/opt/module/kubernetes/ssl/ca.pem \\
--cluster-signing-key-file=/opt/module/kubernetes/ssl/ca-key.pem \\
--root-ca-file=/opt/module/kubernetes/ssl/ca.pem \\
--service-account-private-key-file=/opt/module/kubernetes/ssl/ca-key.pem \\
--experimental-cluster-signing-duration=87600h0m0s"
EOF

# systemd 管理 controller-manager
echo "make controller-manager be managed by systemd ..."
cat > /usr/lib/systemd/system/kube-controller-manager.service << EOF
[Unit]
Description=Kubernetes Controller Manager 
Documentation=https://github.com/kubernetes/kubernetes
[Service]
EnvironmentFile=/opt/module/kubernetes/cfg/kube-controller-manager.conf 
ExecStart=/opt/module/kubernetes/bin/kube-controller-manager \$KUBE_CONTROLLER_MANAGER_OPTS 
Restart=on-failure
[Install] 
WantedBy=multi-user.target 
EOF

# 启动并设置开机启动
echo "start controller-manager service ..."
systemctl daemon-reload
systemctl start kube-controller-manager
systemctl enable kube-controller-manager

# 创建kube-scheduler配置文件
echo "create scheduler config file ..."
cat > /opt/module/kubernetes/cfg/kube-scheduler.conf << EOF
KUBE_SCHEDULER_OPTS="--logtostderr=false \
--v=2 \
--log-dir=/opt/module/kubernetes/logs \
--leader-elect \
--master=127.0.0.1:8080 \
--bind-address=127.0.0.1"
EOF

# systemd 管理 scheduler
echo "make scheduler be managed by systemd ..."
cat > /usr/lib/systemd/system/kube-scheduler.service << EOF
[Unit]
Description=Kubernetes Scheduler
Documentation=https://github.com/kubernetes/kubernetes
[Service]
EnvironmentFile=/opt/module/kubernetes/cfg/kube-scheduler.conf
ExecStart=/opt/module/kubernetes/bin/kube-scheduler \$KUBE_SCHEDULER_OPTS
Restart=on-failure
[Install]
WantedBy=multi-user.target
EOF

# 启动并设置开机启动
echo "start scheduler service ..."
systemctl daemon-reload
systemctl start kube-scheduler
systemctl enable kube-scheduler
