provider "aws" {
  region = "us-east-1"
  access_key = "" //our creds
  secret_key = ""
}

resource "aws_instance" "my_ubuntu" {
  ami           = "ami-0043d23dw223423"
  instance_type = "t3.micro"

  tags = {
    Name = "my_ubuntu_server"
    Owner = "alex"
  }
}

resource "aws_instance" "amazon_server" {
  ami           = "ami-0043d23dwsdfsdf"
  instance_type = "t2.micro"

  tags = {
    Name = "amazon_server"
    Owner = "alex"
  }
}
