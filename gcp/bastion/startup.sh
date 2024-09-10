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
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y curl wget

# # setup logstash
# wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elastic-keyring.gpg
# sudo apt-get install apt-transport-https
# echo "deb [signed-by=/usr/share/keyrings/elastic-keyring.gpg] https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-8.x.list
# sudo apt-get update && sudo apt-get install logstash -y

# Clean up
sudo apt-get clean
