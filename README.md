Prepare VMs:
1. go to this current project folder.
2. run "vagrant up" or "vagrant up --provision" if the VMs has been created.
   
   "vagrant halt" command is to shut down the VMs
    
3. copy private key of the host machine to VMs
   (only the first time to create VMs)
   ```
   ssh-copy-id -i ~/.ssh/id_rsa hadoop@hadoop101
   ssh-copy-id -i ~/.ssh/id_rsa hadoop@hadoop102
   ssh-copy-id -i ~/.ssh/id_rsa hadoop@hadoop103
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

