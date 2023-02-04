# FOSDEM 2023

## Exploring Database Containers: Docker and Percona Server for MySQL

```bash
# Accessing the detached container
docker exec -it percona-server-2 /bin/bash

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
```

```bash
# Logical backup using mysqldump
docker exec -it percona-server mysqldump -u root --password=root < /path/in/physical/host/dump.sql
```

```sql
mysql -uroot -proot
USE cinema;
```
