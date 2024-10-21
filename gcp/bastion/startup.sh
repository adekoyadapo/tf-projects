#!/bin/bash

# Function to check network connectivity
check_network() {
    echo "Checking network connectivity..."
    local attempt=1
    local max_attempts=10

    while ! ping -c 1 www.google.com &>/dev/null; do
        echo "Network is not available, attempt $attempt of $max_attempts, waiting..."
        attempt=$((attempt + 1))
        if [ $attempt -gt $max_attempts ]; then
            echo "Network is not available after $max_attempts attempts. Exiting."
            exit 1
        fi
        sleep 5
    done
    echo "Network is available."
}

# Check network connectivity
check_network

# Check network connectivity
check_network
# Update package lists
sudo apt-get update -y

# Install curl and wget non-interactively
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y curl wget bind9-dnsutils

# # setup logstash
# wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elastic-keyring.gpg
# sudo apt-get install apt-transport-https
# echo "deb [signed-by=/usr/share/keyrings/elastic-keyring.gpg] https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-8.x.list
# sudo apt-get update && sudo apt-get install logstash -y

# Install Docker
echo "Installing Docker..."
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Add the current user to the docker group
sudo usermod -aG docker $USER

# Start Docker service
sudo systemctl start docker

# Enable Docker to start on boot
sudo systemctl enable docker

# Verify Docker installation
docker --version

echo "Docker installation completed."

# Install Miniconda
echo "Installing Miniconda..."

# Download Miniconda installer
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh

# Install Miniconda system-wide
sudo bash /tmp/miniconda.sh -b -p /opt/miniconda

# Add Miniconda to system PATH
echo 'export PATH="/opt/miniconda/bin:$PATH"' | sudo tee /etc/profile.d/miniconda.sh

# Make the changes take effect
source /etc/profile.d/miniconda.sh

# Initialize conda for bash shell
conda init bash

# Clean up
rm /tmp/miniconda.sh

echo "Miniconda installation completed."

# Clean up
sudo apt-get clean
