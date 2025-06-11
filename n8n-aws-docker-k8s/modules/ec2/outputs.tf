output "public_ip" {
  value = aws_eip.n8n.public_ip
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

output "lb_dns_name" {
  value = aws_lb.n8n.dns_name
}