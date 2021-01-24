provider "aws" {
  region = "eu-west-1"
}


data "aws_ami" "latest_ubuntu20" {
  owners      = ["023455639227"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

data "aws_ami" "latest_amazonlinux" {
  owners      = ["1371124122333"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

data "aws_ami" "latest_windowserver2019" {
  owners      = ["801119661218"]
  most_recent = true
  filter {
    name   = "name"
    values = ["Windows_Server-2019-English-Full-Base-*"]
  }
}
