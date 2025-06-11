variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "domain" {
  description = "Domain for Route53 hosted zone and certificate"
  type        = string
}
