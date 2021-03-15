provider "aws" {
  region = var.aws_region
}

data "aws_ami" "latest_amazon_linux" {
  owners      = ["1221214122918"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_eip" "web" {
  instance = aws_instance.web.id
  tags     = merge(var.tags, { Name = "${var.tags["Environment"]}-EIP for WebServer Built by Terraform" })
}


resource "aws_instance" "web" {
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = var.instance_size
  vpc_security_group_ids = [aws_security_group.web.id]
  key_name               = var.key_pair
  user_data              = file("user_data.sh")
  tags                   = merge(var.tags, { Name = "${var.tags["Environment"]}-WebServer Built by Terraform" })

  lifecycle {
    create_before_destroy = true
  }
}

esource "aws_security_group" "web" {
  name        = "${var.tags["Environment"]}-WebServer-SG"
  description = "Security Group for my ${var.tags["Environment"]} WebServer"

  dynamic "ingress" {
    for_each = var.port_list
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    description = "Allow ALL ports"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(var.tags, { Name = "${var.tags["Environment"]}-WebServer SG by Terraform" })
}