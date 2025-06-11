output "instance_public_ip" {
  value = module.n8n_instance.public_ip
}

output "vpc_id" {
  value = module.n8n_instance.vpc_id
}

output "subnet_ids" {
  value = module.n8n_instance.subnet_ids
}

output "hosted_zone_id" {
  value = module.dns_acm.hosted_zone_id
}

output "route53_record_name" {
  value = module.n8n_instance.route53_record_name
}

output "lb_dns_name" {
  value = module.n8n_instance.lb_dns_name
}

output "certificate_arn" {
  value = module.dns_acm.certificate_arn
}