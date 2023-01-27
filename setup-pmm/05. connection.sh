# In MySQL
CREATE USER 'pmm'@'172.17.0.3' IDENTIFIED BY 'pass' WITH MAX_USER_CONNECTIONS 10;
GRANT SELECT, PROCESS, REPLICATION CLIENT, RELOAD, BACKUP_ADMIN ON *.* TO 'pmm'@'172.17.0.3';
# Replacing pass with your desired password
# Replacing localhost with the IP address of the PMM Client container.

#And finally, register the MySQL server for monitoring:
docker exec pmm-client pmm-admin add mysql --username=pmm --password=pass --host 172.17.0.4 --query-source=perfschema
# where --host 172.17.0.4 is the IP of MySQL