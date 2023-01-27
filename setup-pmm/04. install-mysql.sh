# Update the package repositories
sudo apt update

# Install the curl download utility if needed
sudo apt install curl

# Download the percona-release repository package:
curl -O https://repo.percona.com/apt/percona-release_latest.generic_all.deb

# Install the downloaded package with apt as root or with sudo
sudo apt install gnupg2 lsb-release ./percona-release_latest.generic_all.deb

# Refresh the local cache to update the package information
sudo apt update

# Use percona-release to set up the repository for the Percona Server for MySQL 8.0 version:
sudo percona-release setup ps80

# Install the server package with the percona-release command:
sudo apt install percona-server-server

# Login into Percona MySQL
mysql -uroot -p


# Create Database and Insert Data


CREATE DATABASE cinema;
USE cinema;

CREATE TABLE movies (
  book_id BIGINT PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(100) UNIQUE NOT NULL,
  publisher VARCHAR(100) NOT NULL,
  labels JSON NOT NULL
) ENGINE = InnoDB;

INSERT INTO movies(title,publisher, labels) 
VALUES('Green House', 'Joe Monter', '{"about" : {"gender": "action", "cool": true, "notes": "labeled"}}');

INSERT INTO movies(title,publisher, labels) 
VALUES('El camino', 'Daniil Zotl', '{"about" : {"gender": "documental", "cool": true, "notes": "labeled"}}');

INSERT INTO movies(title,publisher, labels) 
VALUES('Shape', 'Aleks Garcia', '{"about" : {"gender": "documental", "cool": true, "notes": "labeled"}}');


select * from movies;


# Installing Percona MySQl with Docker
docker run -d \
  --name ps \
  -e MYSQL_ROOT_PASSWORD=root \
  percona/percona-server:8.0

# Let's check Percona MySQL container IP
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' your_container
#Example: 172.17.0.4 

# For configuring PMM for monitoring MySQL, we need to create a PMM user. First, log into MySQL
docker run -it --rm percona mysql -h 172.17.0.4 -uroot -p

# Use password: root