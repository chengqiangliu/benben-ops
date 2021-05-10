docker exec -it redis-7001 bash

redis-cli --cluster create 192.168.10.201:7001 192.168.10.201:7002 192.168.10.201:7003 192.168.10.201:7004 192.168.10.201:7005 192.168.10.201:7006 \
          --cluster-replicas 1