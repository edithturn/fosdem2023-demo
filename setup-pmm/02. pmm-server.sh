
# Create data volume
docker create --volume /srv --name pmm-data \
percona/pmm-server:2 /bin/true

# Run pmm server container
docker run --detach --restart always \
--publish 443:443 \
--volumes-from pmm-data \
--name pmm-server \
percona/pmm-server:2
