output "public_ip" {
  value = aws_eip.n8n.public_ip
}

output "instance_id" {
  value = aws_instance.n8n.id
}

output "vpc_id" {
  value = aws_vpc.n8n.id
}

output "subnet_ids" {
  value = [for s in aws_subnet.n8n : s.id]
}

output "lb_dns_name" {
  value = aws_lb.n8n.dns_name
}

output "route53_zone_id" {
  value = aws_route53_zone.public.zone_id
}

output "route53_record_name" {
  value = aws_route53_record.root.fqdn
}