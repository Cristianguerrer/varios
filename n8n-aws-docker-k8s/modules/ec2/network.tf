# Basic network resources

resource "aws_vpc" "n8n" {
  cidr_block = var.vpc_cidr
}

data "aws_availability_zones" "available" {}

locals {
  azs = data.aws_availability_zones.available.names
}

resource "aws_subnet" "n8n" {
  for_each = { for idx, cidr in var.subnet_cidrs : idx => cidr }

  vpc_id            = aws_vpc.n8n.id
  cidr_block        = each.value
  availability_zone = local.azs[each.key % length(local.azs)]
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
  for_each       = aws_subnet.n8n
  subnet_id      = each.value.id
  route_table_id = aws_route_table.n8n.id
}
