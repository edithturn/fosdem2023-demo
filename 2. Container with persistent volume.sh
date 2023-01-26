# Demo: Creating a Database with a persistent volume


# 0. Let's delete the previous container
docker ps
docker rm -f percona-server

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
