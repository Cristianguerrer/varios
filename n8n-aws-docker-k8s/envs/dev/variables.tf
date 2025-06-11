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

