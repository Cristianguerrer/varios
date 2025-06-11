variable "region" {
  description = "AWS region"
  type        = string
}

variable "instance_name" {
  description = "Name tag for the instance"
  type        = string
  default     = "n8n-server"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "subnet_cidrs" {
  description = "List of CIDR blocks for the subnets"
  type        = list(string)
}

variable "domain" {
  description = "Domain for Route53 hosted zone"
  type        = string
}

# variable "acm_certificate_arn" {
#   description = "ARN of the ACM certificate for the HTTPS listener"
#   type        = string
# }

variable "tags" {
  description = "Tags to apply to created resources"
  type        = map(string)
}
