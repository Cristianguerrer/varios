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
