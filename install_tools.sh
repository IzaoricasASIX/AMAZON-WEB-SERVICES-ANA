#!/bin/bash

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
