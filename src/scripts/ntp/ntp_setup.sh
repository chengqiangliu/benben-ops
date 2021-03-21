scp src/scripts/ntp/ntp_server_config.sh root@hadoop101:/root
ssh root@hadoop101 '/root/ntp_server_config.sh'

for((host=102; host<=103; host++)); do
  scp src/scripts/ntp/ntp_client_config.sh root@hadoop${host}:/root
  ssh root@hadoop${host} '/root/ntp_client_config.sh'
done