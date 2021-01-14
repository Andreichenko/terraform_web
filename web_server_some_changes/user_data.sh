#!/bin/bash
yum update -y
yum install httpd -y
MYIP='curl http://169.254.169.254/latest/meta-data/local-ipv4'
echo "<h2> Webserver with privateIP: $MYIP</h2><br>Build by Terraform external file" > /var/www/index.html
systemctl start httpd
chkconfig httpd on