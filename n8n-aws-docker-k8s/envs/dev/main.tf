module "n8n_instance" {
  source        = "../../modules/ec2"
  region        = var.region
  instance_name = var.instance_name
  instance_type = var.instance_type
}
