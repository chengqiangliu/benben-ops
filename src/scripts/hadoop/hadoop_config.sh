#!/bin/bash

# move into /opt/module folder
cd /opt/module

echo "untar hadoop ..."
tar -xvzf hadoop-2.9.2.tar.gz

echo "removing hadoop-2.9.2.tar.gz tar file..."
rm hadoop-2.9.2.tar.gz

echo "update /etc/profile config..."
HADOOP_HOME=/opt/module/hadoop-2.9.2
echo 'hadoop' | sudo -S sed -i '$aexport HADOOP_HOME='"${HADOOP_HOME}"'\nexport PATH=\$PATH:\$HADOOP_HOME\/bin\nexport PATH=\$PATH:\$HADOOP_HOME\/sbin' /etc/profile
source /etc/profile

echo "update hadoop-env.sh config..."
sed -i 's/export JAVA_HOME=${JAVA_HOME}/export JAVA_HOME=\/opt\/module\/jdk1.8.0_281/g' /opt/module/hadoop-2.9.2/etc/hadoop/hadoop-env.sh

echo "update yarn-env.sh config..."
sed -i 's/# export JAVA_HOME=\/home\/y\/libexec\/jdk1.6.0\//export JAVA_HOME=\/opt\/module\/jdk1.8.0_281/g' /opt/module/hadoop-2.9.2/etc/hadoop/yarn-env.sh

echo "update mapred-env.sh config..."
sed -i 's/# export JAVA_HOME=\/home\/y\/libexec\/jdk1.6.0\//export JAVA_HOME=\/opt\/module\/jdk1.8.0_281/g' /opt/module/hadoop-2.9.2/etc/hadoop/mapred-env.sh

echo "hadoop installation finished!"
