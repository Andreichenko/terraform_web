provider "aws" {
  region = "us-east-1"
  access_key = "" //our creds
  secret_key = ""
}

resource "aws_instance" "my_ubuntu" {
  ami           = "ami-0043d23dw223423"
  instance_type = "t3.micro"
  key_name = "Frei"

  tags = {
    Name = "my_ubuntu_server"
    Owner = "alex"
    Project = "AZ01M"
  }
}

resource "aws_instance" "amazon_server" {
  ami           = "ami-0043d23dwsdfsdf"
  instance_type = "t3.small"

  tags = {
    Name = "amazon_linux_server"
    Owner = "alex"
  }
}