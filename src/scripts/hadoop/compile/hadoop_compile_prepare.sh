#!/bin/bash


echo "install Maven ..."
source /root/bin/maven_install.sh

echo "install Ant ..."
source /root/bin/ant_install.sh

echo "install dependencies ..."
yum install -y glibc-headers gcc-c++ make cmake openssl-devel ncurses-devel

echo "install protobuf-2.5.0 ..."
echo "Untar protobuf into /opt/module..."
cd /opt/module/
tar -zxvf protobuf-2.5.0.tar.gz >/dev/null 2>&1
echo "removing protobuf-2.5.0.tar.gz tar file..."
sudo rm protobuf-2.5.0.tar.gz

cd /opt/module/protobuf-2.5.0/
./configure
make
make check
make install
ldconfig


echo "making protobuf-2.5.0 available in the system..."
LD_LIBRARY_PATH=/opt/module/protobuf-2.5.0
echo "export LD_LIBRARY_PATH="$LD_LIBRARY_PATH >>/etc/profile
echo "export PATH=\$PATH:\$LD_LIBRARY_PATH" >>/etc/profile
source /etc/profile

protoc --version
echo "protobuf installation finished!"

cd /opt/module
echo "Untar hadoop-2.9.2-src.tar.gz into /opt/module..."
tar -zxvf hadoop-2.9.2-src.tar.gz >/dev/null 2>&1
echo "removing hadoop-2.9.2-src.tar.gz tar file..."
sudo rm /opt/module/hadoop-2.9.2-src.tar.gz

cd hadoop-2.9.2-src
mvn package -Pdist,native -DskipTests -Dtar



