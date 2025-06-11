provider "aws" {
  region = var.region
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_security_group" "n8n" {
  name_prefix = "${var.instance_name}-sg-"

  ingress {
    description = "n8n"
    from_port   = 5678
    to_port     = 5678
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "n8n" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  security_groups = [aws_security_group.n8n.name]
  user_data     = file("${path.module}/user_data.sh")

  tags = {
    Name = var.instance_name
  }
}

output "public_ip" {
  value = aws_instance.n8n.public_ip
}

output "instance_id" {
  value = aws_instance.n8n.id
}
