output "instance_public_ip" {
  value = module.n8n_instance.public_ip
}

output "vpc_id" {
  value = module.n8n_instance.vpc_id
}

output "subnet_ids" {
  value = module.n8n_instance.subnet_ids
}

output "route53_zone_id" {
  value = module.n8n_instance.route53_zone_id
}

output "route53_record_name" {
  value = module.n8n_instance.route53_record_name
}

output "lb_dns_name" {
  value = module.n8n_instance.lb_dns_name
}