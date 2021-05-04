#!/bin/bash

mkdir -p /mydata/mysql/master/log /mydata/mysql/master/data /mydata/mysql/master/conf

cat << EOF > mydata/mysql/master/conf/my.cnf
[client]
default-character-set=utf8mb4
[mysql]
default-character-set=utf8mb4
[mysqld]
character-set-client-handshake
init_connect='SET collation_connection = utf8mb4_unicode_ci'
init_connect='SET NAMES utf8mb4'
character-set-server=utf8mb4
# collaction-server=utf8mb4_unicode_ci
skip-name-resolve
server-id=1
log-bin=mysql-bin
read-only=0
binlog-do-db=benbenmall_ums
binlog-do-db=benbenmall_pms
binlog-do-db=benbenmall_oms
binlog-do-db=benbenmall_sms
binlog-do-db=benbenmall_wms
binlog-do-db=benbenmall_admin
replicate-ignore-db=mysql
replicate-ignore-db=sys
replicate-ignore-db=information_schema
EOF

cat << EOF > mydata/mysql/slave01/conf/my.cnf
[client]
default-character-set=utf8mb4
[mysql]
default-character-set=utf8mb4
[mysqld]
character-set-client-handshake
init_connect='SET collation_connection = utf8mb4_unicode_ci'
init_connect='SET NAMES utf8mb4'
character-set-server=utf8mb4
# collaction-server=utf8mb4_unicode_ci
skip-name-resolve
server-id=2
log-bin=mysql-bin
read-only=1
binlog-do-db=benbenmall_ums
binlog-do-db=benbenmall_pms
binlog-do-db=benbenmall_oms
binlog-do-db=benbenmall_sms
binlog-do-db=benbenmall_wms
binlog-do-db=benbenmall_admin
replicate-ignore-db=mysql
replicate-ignore-db=sys
replicate-ignore-db=information_schema
EOF

docker pull mysql:5.7
docker run -p 3316:3306 --name mysql-master \
           -v /mydata/mysql/master/log:/var/log/mysql \
           -v /mydata/mysql/master/data:/var/lib/mysql \
           -v /mydata/mysql/master/conf:/etc/mysql \
           -e MYSQL_ROOT_PASSWORD=root \
           -d mysql:5.7

docker run -p 3317:3306 --name mysql-slave01 \
           -v /mydata/mysql/slave01/log:/var/log/mysql \
           -v /mydata/mysql/slave01/data:/var/lib/mysql \
           -v /mydata/mysql/slave01/conf:/etc/mysql \
           -e MYSQL_ROOT_PASSWORD=root \
           -d mysql:5.7

docker update mysql-master --restart=always
docker update mysql-slave01 --restart=always

docker cp ./master-setting.sql mysql-master:/
docker cp ./slave-setting.sql mysql-slave01:/

docker exec mysql-master mysql -u root -ppassword < /master-setting.sql
docker exec mysql-slave01 mysql -u root -ppassword < /slave-setting.sql
