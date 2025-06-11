module "n8n_instance" {
  source        = "../../modules/ec2"
  region        = var.region
  instance_name = var.instance_name
  instance_type = var.instance_type
  vpc_cidr      = var.vpc_cidr
  subnet_cidr   = var.subnet_cidr
}

resource "aws_route53_zone" "public" {
  name = var.domain
}

resource "aws_route53_record" "root" {
  zone_id = aws_route53_zone.public.zone_id
  name    = var.domain
  type    = "A"
  ttl     = 300
  records = [module.n8n_instance.public_ip]
}
