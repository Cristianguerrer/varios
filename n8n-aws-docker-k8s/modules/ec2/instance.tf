data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "n8n" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.n8n.id
  vpc_security_group_ids = [aws_security_group.n8n.id]
  associate_public_ip_address = false
  user_data             = file("${path.module}/user_data.sh")

  tags = {
    Name = var.instance_name
  }
}

resource "aws_eip" "n8n" {
  instance = aws_instance.n8n.id
  domain   = "vpc"
}
