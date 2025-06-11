region = "us-east-1"
instance_name = "n8n-dev"
instance_type = "t2.micro"
vpc_cidr = "10.0.0.0/16"
subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
domain = "laboratoriosconcristian.site"
tags = {
  Environment = "dev"
  Owner       = "terraform"
  Project     = "n8n"
}