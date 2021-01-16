
provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "web_sec" {

  name        = "Webserver-SG"
  description = "SG for web server"

  dynamic "ingress" {
    for_each = ["80", "8081", "443"]
    content {
      description = "Allow port HTTP 80"
      from_port = ingress.value
      protocol = "tcp"
      to_port = ingress.value
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  ingress {
    description = "Allow port SSH"
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["10.200.0.0/16"]
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