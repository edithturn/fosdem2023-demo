# This Dockerfile should be used for docker official repo

# https://github.com/docker-library/official-images:
# No official images can be derived from, or depend on, non-official images
# with the following notable exceptions...
FROM ubuntu:20.04 
RUN apt update && apt install curl gnupg2 lsb-release -y 
 
RUN curl -O https://repo.percona.com/apt/percona-release_latest.generic_all.deb 
RUN DEBIAN_FRONTEND=noninteractive apt-get install ./percona-release_latest.generic_all.deb -y 
 
RUN apt update 
RUN percona-release setup ps80 
RUN DEBIAN_FRONTEND=noninteractive apt install -y percona-server-server

VOLUME ["/var/lib/mysql", "/var/log/mysql"]

CMD /usr/sbin/mysqld -u mysql

EXPOSE 3306
