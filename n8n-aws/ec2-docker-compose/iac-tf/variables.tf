variable "aws_region" {
  default = "us-east-1"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ami_id" {  # MODIFICACIÓN: Se usa una AMI fija
  default = "ami-04681163a08179f28"
}

variable "key_name" {
  default = "mi-clave-terraform"
}

variable "n8n_domain" {
  default = "n8n.laboratoriosconcristian.site"
}
