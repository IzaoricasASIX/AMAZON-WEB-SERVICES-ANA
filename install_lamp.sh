#!/bin/bash

# Update packages
sudo apt update
sudo apt upgrade -y

# Install Apache
sudo apt install apache2 -y

# Install MySQL
sudo apt install mysql-server -y

# Install PHP
sudo apt install php libapache2-mod-php php-mysql -y

# Restart Apache
sudo systemctl restart apache2

# Enable services at startup
sudo systemctl enable apache2
sudo systemctl enable mysql

# Create a PHP test page
echo "<?php phpinfo(); ?>" | sudo tee /var/www/html/info.php

echo "LAMP installation completed!"
echo "Apache: http://54.234.103.159/"
echo "PHP: http://54.234.103.159/info.php"
