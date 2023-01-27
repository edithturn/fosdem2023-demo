
# Installing PMM Server with Docker and Docker volume

# Get the Docker image
docker pull percona/pmm-server:2

# Create a volume
docker volume create pmm-data

# Run pmm server container
docker run --detach --restart always \
--publish 443:443 \
-v pmm-data:/srv \
--name pmm-server \
percona/pmm-server:2


# Change the password for the default admin user
docker exec -t pmm-server change-admin-password <new_password>