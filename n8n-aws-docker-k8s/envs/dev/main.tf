module "n8n_instance" {
  source        = "../../modules/ec2"
  region        = var.region
  instance_name = var.instance_name
  instance_type = var.instance_type
  vpc_cidr      = var.vpc_cidr
  subnet_cidr   = var.subnet_cidr
  # acm_certificate_arn = var.acm_certificate_arn
  tags                = var.tags
  domain   = var.domain
}