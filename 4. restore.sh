# FOSDEM 2023
## Exploring Database Containers


# Demo: Creating a Database without a persistent volume

# 1. Starting a detached container.
# Docker run command is basically a combination of three docker commands: docker pull, docker create, and docker start
docker run -d --name percona-server -e MYSQL_ROOT_PASSWORD=root percona/percona-server:8.0

# 2. List of container
docker container ps

# 3. Accessing the detached container: 
docker exec -it percona-server /bin/bash

# 4. Connecting to the database
mysql -uroot -proot

# 5. Create a Database "cinema" and use it
CREATE DATABASE cinema;
USE cinema;

# 6. Create table movies in Database "cinema"
CREATE TABLE movies (
  book_id BIGINT PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(100) UNIQUE NOT NULL,
  publisher VARCHAR(100) NOT NULL,
  labels JSON NOT NULL
) ENGINE = InnoDB;

# 7. Insert data into Database "cinema"
INSERT INTO movies(title,publisher, labels) 
VALUES('Green House', 'Joe Monter', '{"about" : {"gender": "action", "cool": true, "notes": "labeled"}}');

# 8. Checking table
select * from movies;

# Demo: Creating a Database with a persistent volume

# 1. Starting a detached container with persistent volume
docker run -d --name percona-server -e MYSQL_ROOT_PASSWORD=root -v /tmp/storage:/var/lib/mysql percona/percona-server:8.0

# 2. Listen all the volumes
docker volume ls
docker inspect <container-id> | grep 'volume'
ls /tmp/storage

# 3. Inspecting percona-server container
# This is the default data directory path in MySQL, and you can customize it. 
docker exec -it percona-server /bin/bash
ls /var/lib/mysql

# Backup  <CHECK>
# Logical backup using mysqldump
docker exec -it percona-server mysqldump -u root --password=root --single-transaction > /path/in/physical/host/dump.sql

# Using Percona Xtrabackup
docker run --rm -it \
--net cinema \
-v mysql-datadir:/var/lib/mysql \
-v /tmp/backup:/xtrabackup_backupfiles \
perconalab/percona-xtrabackup \
--backup --host=mysql-prod --user=root --password=password

# Restore  <CHECK>
# mysqldump
docker exec -it percona-server mysql -uroot -p < /path/in/physical/host/dump.sql

# Xtrabackup
cat backup.sql | docker exec -i CONTAINER /usr/bin/mysql -u root --password=root cinema

# You can also pass any shell command to be running inside the container. 
docker exec -it mysql-test mysql -uroot -p -e ‘SELECT @@innodb_buffer_pool_size’

# 