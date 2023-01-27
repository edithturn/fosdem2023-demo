# With Docker
# Create data volume for PMM Client
docker create --volume /srv --name pmm-client-data \
percona/pmm-client:2 /bin/true

# Run PMM CLient container
# Update 172.17.0.2 with the IP of your PMM Server container.
# Get the IP of the container with:  docker inspect <container-id> | grep IPAddress
PMM_SERVER=172.17.0.2:443 
docker run \
--rm \
--name pmm-client \
-e PMM_AGENT_SERVER_ADDRESS=${PMM_SERVER} \
-e PMM_AGENT_SERVER_USERNAME=admin \
-e PMM_AGENT_SERVER_PASSWORD=newadm \
-e PMM_AGENT_SERVER_INSECURE_TLS=1 \
-e PMM_AGENT_SETUP=1 \
-e PMM_AGENT_CONFIG_FILE=config/pmm-agent.yaml \
--volumes-from pmm-client-data \
percona/pmm-client:2


# Debian-based
wget https://repo.percona.com/apt/percona-release_latest.generic_all.deb
sudo dpkg -i percona-release_latest.generic_all.deb
sudo apt update
sudo apt install -y pmm2-client
sudo pmm-admin --version
