### Prepare VMs:
1. go to this current project folder.
2. run "vagrant up" or "vagrant up --provision" if the VMs has been created.
   
   "vagrant halt" command is to shut down the VMs
    
3. copy private key of the host machine to VMs
   (only the first time to create VMs)
   ```
   ssh-copy-id -i ~/.ssh/id_rsa hadoop@hadoop101
   ssh-copy-id -i ~/.ssh/id_rsa root@hadoop101
   ssh-copy-id -i ~/.ssh/id_rsa hadoop@hadoop102
   ssh-copy-id -i ~/.ssh/id_rsa root@hadoop102
   ssh-copy-id -i ~/.ssh/id_rsa hadoop@hadoop103
   ssh-copy-id -i ~/.ssh/id_rsa root@hadoop103
   ```
4. generate SSH key for hadoop user in the VMs
   (only the first time to create VMs)
   ```
   ./src/scripts/init/generateSSHkey.sh
   ```
5. ssh to VM
   ```
   ssh hadoop@hadoop101
   ssh hadoop@hadoop102
   ssh hadoop@hadoop103
   ```
6. copy private key among the VMs
   (only the first time to create VMs)

   ```
   ssh-copy-id -i ~/.ssh/id_rsa hadoop@hadoop101
   ssh-copy-id -i ~/.ssh/id_rsa hadoop@hadoop102
   ssh-copy-id -i ~/.ssh/id_rsa hadoop@hadoop103
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