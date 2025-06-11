output "instance_public_ip" {
  value = module.n8n_instance.public_ip
}

output "vpc_id" {
  value = module.n8n_instance.vpc_id
}

output "subnet_id" {
  value = module.n8n_instance.subnet_id
}
