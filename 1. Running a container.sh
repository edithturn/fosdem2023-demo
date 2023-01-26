# FOSDEM 2023
## Exploring Database Containers

# Demo: Creating a Database WITHOUT a persistent volume

# Starting a detached container
docker run -d --name percona-server-1 -e MYSQL_ROOT_PASSWORD=root percona/percona-server:8.0

# Check images
docker image ls

# List of container
docker container ps

# Accessing the detached container
docker exec -it percona-server-1 /bin/bash

# Connecting to the database
mysql -uroot -proot

# Create a Database "cinema" and use it
CREATE DATABASE cinema;
USE cinema;

# Create table movies in Database "cinema"
CREATE TABLE movies (
  book_id BIGINT PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(100) UNIQUE NOT NULL,
  publisher VARCHAR(100) NOT NULL,
  labels JSON NOT NULL
) ENGINE = InnoDB;

# Insert data into Database "cinema"
INSERT INTO movies(title,publisher, labels) 
VALUES('Green House', 'Joe Monter', '{"about" : {"gender": "action", "cool": true, "notes": "labeled"}}');

# Checking table
select * from movies;

# KILL THE CONTAINER. Where is your data?
docker ps
docker rm -f percona-server