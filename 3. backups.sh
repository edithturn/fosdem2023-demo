
# Backup  <CHECK>
# Logical backup using mysqldump
docker exec -it percona-server mysqldump -u root --password=root --single-transaction > /path/in/physical/host/dump.sql


# Restore -> No include in the presentation
# mysqldump
docker exec -it percona-server mysql -uroot -p < /path/in/physical/host/dump.sql

# Xtrabackup
cat backup.sql | docker exec -i CONTAINER /usr/bin/mysql -u root --password=root cinema

# You can also pass any shell command to be running inside the container. 
docker exec -it mysql-test mysql -uroot -p -e ‘SELECT @@innodb_buffer_pool_size’

# 