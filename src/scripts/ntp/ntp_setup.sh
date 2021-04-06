server_prefix='k8s'
scp src/scripts/ntp/ntp_server_config.sh root@${server_prefix}101:/root
ssh root@hadoop101 '/root/ntp_server_config.sh'

for((host=102; host<=103; host++)); do
  scp src/scripts/ntp/ntp_client_config.sh root@${server_prefix}${host}:/root
  ssh root@${server_prefix}${host} '/root/ntp_client_config.sh'
done