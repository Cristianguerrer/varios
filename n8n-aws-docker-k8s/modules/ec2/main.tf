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

# Basic network resources
resource "aws_vpc" "n8n" {
  cidr_block = var.vpc_cidr
}

data "aws_availability_zones" "available" {}

resource "aws_subnet" "n8n" {
  vpc_id            = aws_vpc.n8n.id
  cidr_block        = var.subnet_cidr
  availability_zone = data.aws_availability_zones.available.names[0]
}

resource "aws_internet_gateway" "n8n" {
  vpc_id = aws_vpc.n8n.id
}

resource "aws_route_table" "n8n" {
  vpc_id = aws_vpc.n8n.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.n8n.id
  }
}

resource "aws_route_table_association" "n8n" {
  subnet_id      = aws_subnet.n8n.id
  route_table_id = aws_route_table.n8n.id
}

resource "aws_security_group" "n8n" {
  name_prefix = "${var.instance_name}-sg-"
  vpc_id      = aws_vpc.n8n.id

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
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.n8n.id
  vpc_security_group_ids = [aws_security_group.n8n.id]
  associate_public_ip_address = true
  user_data             = file("${path.module}/user_data.sh")

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

output "vpc_id" {
  value = aws_vpc.n8n.id
}

output "subnet_id" {
  value = aws_subnet.n8n.id
}
