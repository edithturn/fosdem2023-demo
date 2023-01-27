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

select * from movies;
