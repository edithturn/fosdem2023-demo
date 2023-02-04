# FOSDEM 2023

## Exploring Database Containers: Docker and Percona Server for MySQL

Running Multiple Percona Server MySQL Containers

```bash
docker run -d --name percona-server-1 -e MYSQL_ROOT_PASSWORD=root percona/percona-server:8.0
```

```bash
docker run -d --name percona-server-2 -e MYSQL_ROOT_PASSWORD=root percona/percona-server:8.0
```

```bash
# List Docker Images
docker image ls
```

```bash
# List Docker Containers
docker container ps
```

```bash
#Accessing the detached container
docker exec -it percona-server-1 /bin/bash
```

```bash
# Connecting to the database
mysql -uroot -proot
```

```sql
/* Create a Database "cinema" and use it */

CREATE DATABASE cinema;
USE cinema;

/* Create table movies in Database "cinema" */

CREATE TABLE movies (
book_id BIGINT PRIMARY KEY AUTO_INCREMENT,
title VARCHAR(100) UNIQUE NOT NULL,
publisher VARCHAR(100) NOT NULL,
labels JSON NOT NULL
) ENGINE = InnoDB;

/* Insert data into Database "cinema" */

INSERT INTO movies(title,publisher, labels)
VALUES('Green House', 'Joe Monter', '{"about" : {"gender": "action", "cool": true, "notes": "labeled"}}');

/* Checking table */

select * from movies;

/* KILL THE CONTAINER! Where is your data? */

docker ps
docker rm -f percona-server-1
```
