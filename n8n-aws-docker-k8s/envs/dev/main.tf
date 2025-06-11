module "n8n_instance" {
  source        = "../../modules/ec2"
  region        = var.region
  instance_name = var.instance_name
  instance_type = var.instance_type
  vpc_cidr      = var.vpc_cidr
  subnet_cidrs  = var.subnet_cidrs
  tags                = var.tags
  domain   = var.domain
  record_name = var.record_name
}