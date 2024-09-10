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
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y curl wget bind9-utils

# Clean up
sudo apt-get clean
