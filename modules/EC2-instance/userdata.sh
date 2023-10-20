#!/bin/bash
sudo apt update
sudo apt install apache2
systemctl start apache2
systemctl enable apache2
echo "<html><h1>Hello from your EC2 instance!</h1></html>" > /var/www/html/index.html