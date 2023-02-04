# FOSDEM 2023

## Exploring Database Containers: Docker and Percona Server for MySQL

```bash
docker ps
docker rm -f percona-server
```

```bash
# Starting a detached container with persistent volume
docker run -d --name percona-server-2 -e MYSQL_ROOT_PASSWORD=root -v /tmp/storage:/var/lib/mysql percona/percona-server:8.0
```

```bash
# Show all the volumes

docker volume ls
docker inspect percona-server-2 | grep 'volume'
ls /tmp/storage
```

```bash
# Inspecting percona-server container

# This is the default data directory path in MySQL, and you can customize it.

docker exec -it percona-server-2 /bin/bash
ls /var/lib/mysql
```
