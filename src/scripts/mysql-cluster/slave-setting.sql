CHANGE MASTER TO master_host='192.168.10.202', master_user='backup', master_password='123456', master_port=3316, master_log_file='mysql-bin.000001', master_log_pos=0;
start slave;
show slave status;