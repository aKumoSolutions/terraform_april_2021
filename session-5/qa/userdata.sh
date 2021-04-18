#!/bin/bash
sudo yum install httpd -y
sudo echo "Hello from ${environment} EC2" >> /var/www/html/index.html
sudo systemctl start httpd