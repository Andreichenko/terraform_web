#!/bin/bash
yum update -y
yum install httpd -y
MYIP='curl http://169.254.169.254/latest/meta-data/local-ipv4'
cat <<EOF > /var/www/index.html
<html>
<h2> bult by power <front color="red"> terraform</front></h2><br>

server owner is: ${f_name} ${l_name} <br>

%{for x in names ~}
working with ${x} from ${f_name} <br>
%{endfor ~}
</html>
    EOF

systemctl start httpd
chkconfig httpd on