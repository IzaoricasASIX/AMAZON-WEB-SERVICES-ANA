#!/bin/bash

set -e

# Load environment variables
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -f "$SCRIPT_DIR/.env" ]; then
    source "$SCRIPT_DIR/.env"
else
    echo "ERROR: .env file not found."
    exit 1
fi

echo "======================================"
echo " Installing additional tools"
echo "======================================"

sudo apt update

# --------------------------------------
# phpMyAdmin
# --------------------------------------

echo "[1/4] Installing phpMyAdmin..."

sudo DEBIAN_FRONTEND=noninteractive apt install -y phpmyadmin

# Enable required PHP extensions
sudo phpenmod mbstring

# Configure Apache for phpMyAdmin
if [ -f /etc/phpmyadmin/apache.conf ]; then
    if [ ! -L /etc/apache2/conf-enabled/phpmyadmin.conf ]; then
        sudo ln -s /etc/phpmyadmin/apache.conf \
            /etc/apache2/conf-enabled/phpmyadmin.conf
    fi
fi

# --------------------------------------
# Adminer
# --------------------------------------

echo "[2/4] Installing Adminer..."

sudo apt install -y adminer

# Enable Adminer in Apache
if [ -f /etc/apache2/conf-available/adminer.conf ]; then
    sudo a2enconf adminer
fi

# --------------------------------------
# GoAccess
# --------------------------------------

echo "[3/4] Installing GoAccess..."

sudo apt install -y goaccess

# --------------------------------------
# Apache configuration
# --------------------------------------

echo "[4/4] Restarting Apache..."

sudo systemctl restart apache2

echo ""
echo "======================================"
echo " Additional tools installed!"
echo "======================================"
echo ""
echo "phpMyAdmin:"
echo "http://YOUR_ELASTIC_IP/phpmyadmin"
echo ""
echo "Adminer:"
echo "http://YOUR_ELASTIC_IP/adminer"
echo ""
echo "GoAccess:"
echo "Installed and ready to analyze Apache logs."
echo ""#!/bin/bash

echo "===== Installing additional EC2 tools ====="

# Update package list
sudo apt update

# Basic administration tools
sudo apt install -y \
    curl \
    wget \
    unzip \
    zip \
    git \
    vim \
    nano \
    htop \
    tree \
    net-tools \
    dnsutils \
    lsof \
    ca-certificates \
    gnupg \
    software-properties-common

# AWS CLI
sudo snap install aws-cli --classic

echo "===== Installation completed ====="

echo "Installed versions:"
echo "AWS CLI:"
aws --version

echo "Git:"
git --version

echo "Curl:"
curl --version | head -n 1

echo "PHP:"
php --version | head -n 1

echo "===== Done ====="
