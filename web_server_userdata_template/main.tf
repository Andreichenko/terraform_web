
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web" {
  ami                     = "ami-0c9bfc21ac5bf10eb"   //AmazonLinux2
  instance_type           = "t3.micro"
  vpc_security_group_ids  = [aws_security_group.web_sec.id]
  user_data               = templatefile("user_data.sh.tpl", {
    f_name = "Alex"
    l_name = "Frei"
    names  = ["Mihail","Mark","Jeff","Melissa"]
  })

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