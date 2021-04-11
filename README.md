### Vagrant Operations
1. create vagrant box
   vagrant package --base 虚拟机的名字 --output  要创建的box的名字
   如：vagrant package --base cusbox_vb1 --output cusbox
   
2. add custom box to default folder
   vagrant box 的默认目录为~/.vagrant.d/boxes
   vagrant box add 添加后的box名  要添加的box名
   vagrant box add cusbox ./cusbox
   
3. 查看默认目录下的所有box
   vagrant box list
   
### Prepare VMs:
1. go to this current project folder.
2. run "vagrant up" or "vagrant up --provision" if the VMs has been created.
   
   "vagrant halt" command is to shut down the VMs
    
3. copy private key of the host machine to VMs
   (only the first time to create VMs)
   ```
   server_prefix='hadoop'
   username=hadoop
   ssh-copy-id -i ~/.ssh/id_rsa ${username}@${server_prefix}101
   ssh-copy-id -i ~/.ssh/id_rsa ${username}@${server_prefix}102
   ssh-copy-id -i ~/.ssh/id_rsa ${username}@${server_prefix}103
   ```
4. generate SSH key for hadoop user in the VMs
   (only the first time to create VMs)
   ```
   ./src/scripts/init/generateSSHkey.sh
   ```
5. ssh to VM
   ```
   server_prefix='hadoop'
   ssh hadoop@${server_prefix}101
   ssh hadoop@${server_prefix}102
   ssh hadoop@${server_prefix}103
   ```
6. copy private key among the VMs
   (only the first time to create VMs)

   ```
   server_prefix='hadoop'
   username=root
   ssh-copy-id -i ~/.ssh/id_rsa ${username}@${server_prefix}101
   ssh-copy-id -i ~/.ssh/id_rsa ${username}@${server_prefix}102
   ssh-copy-id -i ~/.ssh/id_rsa ${username}@${server_prefix}103
   ```
### Install elasticsearch cluster:
1. go to this current project folder.
2. run the following command to install elasticsearch cluster.
   ```
   ./src/scripts/elasticsearch/elasticsearch_install.sh
   ```
3. run the following command to start elasticsearch cluster.
   ```
   ./src/scripts/elasticsearch/elasticsearch.sh start
   ```
4. run the following command to stop elasticsearch cluster.
   ```
   ./src/scripts/elasticsearch/elasticsearch.sh stop
   ```
### Install kibana:
1. go to this current project folder.
2. run the following command to install kibana.
   ```
   ./src/scripts/kibana/kibana_install.sh
   ```
3. run the following command to start kibana.
   ```
   ./src/scripts/kibana/kibana.sh start
   ```
4. run the following command to stop kibana.
   ```
   ./src/scripts/kibana/kibana.sh stop
   ```

### Install zookeeper:
1. go to this current project folder.
2. run the following command to install kibana.
   ```
   ./src/scripts/zookeeper/zookeeper_install.sh
   ```
3. run the following command to start zookeeper.
   ```
   ./src/scripts/zookeeper/zookeeper.sh start
   ```
4. run the following command to stop zookeeper.
   ```
   ./src/scripts/zookeeper/zookeeper.sh stop
   ```

### Install hadoop:
1. go to this current project folder.
2. run the following command to install hadoop.
   ```
   ./src/scripts/hadoop/hadoop_install.sh
   ```
https://cloud.tencent.com/developer/article/1333862

### Install kafka:
1. go to this current project folder.
2. run the following command to install kafka.
   ```
   ./src/scripts/kafka/kafka_install.sh
   ```
3. run the following command to start kafka.
   ```
   ./src/scripts/kafka/kafka.sh start
   ```
4. run the following command to stop kafka.
   ```
   ./src/scripts/kafka/kafka.sh stop
   ```