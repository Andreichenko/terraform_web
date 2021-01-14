
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web" {
  ami = "ami-0c9bfc21ac5bf10eb"   //AmazonLinux2
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.web_sec.id]
  user_data = <<EOF
  #!/bin/bash
  yum update -y
  yum install httpd -y
  MYIP='curl http://169.254.169.254/latest/meta-data/local-ipv4'
  echo "<h2> Webserver with privateIP: $MYIP</h2><br>Build by Terraform" > /var/www/index.html
  systemctl start httpd
  chkconfig httpd on
  EOF

  tags = {
     key   = "name"
     name  = "Webserver httpd"
     prov  = "Terraform"
     Owner = "Frei"
  }
}

resource "aws_security_group" "web_sec" {

  name        = "Webserver-SG"
  description = "SG for web server"

  ingress {
    description = "Allow port HTTP 80"
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow port HTTPS 443"
    from_port = 443
    protocol = "tcp"
    to_port = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all ports"
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Owner = "Frei"
    Name  = "SG by Terraform"
  }
}