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
echo " Installing LAMP stack"
echo "======================================"

# Update system
echo "[1/6] Updating packages..."
sudo apt update
sudo apt upgrade -y

# Install Apache
echo "[2/6] Installing Apache..."
sudo apt install -y apache2

# Enable Apache
sudo systemctl enable apache2
sudo systemctl start apache2

# Install MySQL
echo "[3/6] Installing MySQL..."
sudo apt install -y mysql-server

sudo systemctl enable mysql
sudo systemctl start mysql

# Install PHP
echo "[4/6] Installing PHP..."
sudo apt install -y \
    php \
    libapache2-mod-php \
    php-mysql \
    php-cli \
    php-curl \
    php-gd \
    php-mbstring \
    php-xml \
    php-zip

# Configure Apache to use PHP
echo "[5/6] Configuring PHP..."

sudo sed -i 's/DirectoryIndex index.html/DirectoryIndex index.php index.html/' \
    /etc/apache2/mods-enabled/dir.conf

sudo systemctl restart apache2

# Create PHP test page
echo "[6/6] Creating PHP test page..."

sudo tee /var/www/html/info.php > /dev/null <<'EOF'
<?php
phpinfo();
?>
EOF

sudo chown www-data:www-data /var/www/html/info.php

echo ""
echo "======================================"
echo " LAMP installation completed!"
echo "======================================"
echo ""
echo "Apache: $(apache2 -v | head -n 1)"
echo "PHP:    $(php -v | head -n 1)"
echo "MySQL:  $(mysql --version)"
echo ""
echo "Test PHP at:"
echo "http://YOUR_ELASTIC_IP/info.php"
echo ""
