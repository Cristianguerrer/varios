resource "aws_security_group" "n8n" {
  name_prefix = "${var.instance_name}-sg-"
  vpc_id      = aws_vpc.n8n.id

  ingress {
    description = "n8n"
    from_port   = 80
    to_port     = 80
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
