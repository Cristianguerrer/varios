output "instance_public_ip" {
  value = module.n8n_instance.public_ip
}

output "vpc_id" {
  value = module.n8n_instance.vpc_id
}

output "subnet_id" {
  value = module.n8n_instance.subnet_id
}

output "route53_zone_id" {
  value = aws_route53_zone.public.zone_id
}

output "route53_record_name" {
  value = aws_route53_record.root.fqdn
}

output "lb_dns_name" {
  value = module.n8n_instance.lb_dns_name
}