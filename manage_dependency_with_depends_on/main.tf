provider "aws" {
  region = "us-east-1"

}

resource "aws_instance" "web" {
  ami = "ami-0bd39c806c2335b95"
  instance_type = "t3.micro"
  vpc_security_group_ids = aws_security_group.general.id
  tags                   = { Name = "Server-Web" }

  depends_on = [
  aws_instance.my_server_db
  aws_instance.my_server_app
  ]
}

resource "aws_instance" "my_server_app" {
  ami = "ami-0bd39c806c2335b95"
  instance_type = "t3.micro"
  vpc_security_group_ids = [
    aws_security_group.general.id]
  tags = {
    Name = "Server-App"
  }
  depends_on = [aws_instance.my_server_db]
}

resource "aws_instance" "my_server_db" {
  ami                    = "ami-0bd39c806c2335b95"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.general.id]
  tags                   = { Name = "Server-DB" }
}


resource "aws_security_group" "general" {
  name = "Security Group"

  dynamic "ingress" {
    for_each = ["80","443","22","3389"]
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
    Name = "My security group"
  }
}