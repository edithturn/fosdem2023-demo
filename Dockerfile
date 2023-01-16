# This Dockerfile should be used for docker official repo

# https://github.com/docker-library/official-images:
# No official images can be derived from, or depend on, non-official images
# with the following notable exceptions...
FROM oraclelinux:8

LABEL org.opencontainers.image.authors="info@percona.com"

ENV PS_VERSION 8.0.30-22.1
ENV OS_VER el8
ENV FULL_PERCONA_VERSION "$PS_VERSION.$OS_VER"
ENV PS_REPO testing

# It is intentionally used another UID, to have backward compatibility with
# the previous image versions published on Docker Hub
RUN set -ex; \
    groupdel input; \
    userdel systemd-coredump; \
    groupadd -g 1001 mysql; \
    useradd -u 1001 -r -g 1001 -s /sbin/nologin \
        -c "Default Application User" mysql



RUN set -ex; \
    yum -y install yum-utils; \
    yum-config-manager --enable ol8_u4_security_validation; \
    rpm -e --nodeps tzdata; \
    dnf -y install \
        hostname \
        tzdata \
        jemalloc \
        which \
        cracklib-dicts \
        tar \
        policycoreutils; \
    \
    yum -y update libgcrypt; \
    dnf -y install \
        percona-server-server-${FULL_PERCONA_VERSION} \
        #percona-server-tokudb-${FULL_PERCONA_VERSION} \
        percona-server-devel-${FULL_PERCONA_VERSION} \
        percona-server-rocksdb-${FULL_PERCONA_VERSION} \
        percona-icu-data-files-${FULL_PERCONA_VERSION}; \
    dnf clean all; \
    rm -rf /var/cache/dnf /var/cache/yum /var/lib/mysql

# purge and re-create /var/lib/mysql with appropriate ownership
RUN set -ex; \
    /usr/bin/install -m 0775 -o mysql -g root -d /var/lib/mysql /var/run/mysqld /docker-entrypoint-initdb.d; \
# comment out a few problematic configuration values
	find /etc/my.cnf /etc/my.cnf.d -name '*.cnf' -print0 \
		| xargs -0 grep -lZE '^(bind-address|log|user)' \
		| xargs -rt -0 sed -Ei 's/^(bind-address|log|user)/#&/'; \
# don't reverse lookup hostnames, they are usually another container
	echo '!includedir /etc/my.cnf.d' >> /etc/my.cnf; \
	printf '[mysqld]\nskip-host-cache\nskip-name-resolve\n' > /etc/my.cnf.d/docker.cnf; \
# TokuDB modifications
	/usr/bin/install -m 0664 -o mysql -g root /dev/null /etc/sysconfig/mysql; \
	echo "LD_PRELOAD=/usr/lib64/libjemalloc.so.1" >> /etc/sysconfig/mysql; \
	echo "THP_SETTING=never" >> /etc/sysconfig/mysql; \
# allow to change config files
	chown -R mysql:root /etc/my.cnf /etc/my.cnf.d; \
	chmod -R ug+rwX /etc/my.cnf /etc/my.cnf.d

VOLUME ["/var/lib/mysql", "/var/log/mysql"]

COPY ps-entry.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

USER mysql
EXPOSE 3306 33060
CMD ["mysqld"]