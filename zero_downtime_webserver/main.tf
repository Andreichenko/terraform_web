provider "aws" {
  region = "us-east-1"
}

resource "aws_eip" "web" {
 instance = aws_instance.web.id
  tags = {
    Name = "EIP for Webwerver"
    Owner = "Frei"
  }

}

resource "aws_instance" "web" {
  ami = "ami-07a0da1997b55b23e" // Amazon Linux2
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.web.id]
  user_data = file("user_data.sh")
  tags = {
    Name = "Webserver Built by Terraform"
    Owner = "Frei"
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "web" {
  name = "Webserver-SG"
  description = "security group for webserver"

  dynamic "ingress" {
    for_each = ["80,"443""]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "webserver"
    Owner = "Frei"
  }
}