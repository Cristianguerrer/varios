# n8n on AWS

This directory contains Terraform configuration for launching an EC2 instance running n8n behind an Application Load Balancer with an ACM certificate.

## Usage

1. Change into the desired environment directory, for example `envs/dev`.
2. Initialize Terraform:

```bash
terraform init
```

3. Create and validate the SSL certificate and DNS records first. This step runs only the `dns_acm` module which provisions Route 53 and ACM resources:

```bash
terraform apply -target=module.dns_acm
```

4. After the certificate has been validated, deploy the rest of the infrastructure:

```bash
terraform apply
```

## Module Variables

The configuration uses a reusable module with the following important variables:

- `domain` – domain of the public Route 53 hosted zone used for the certificate.
- `record_name` – optional subdomain to create as an alias; leave empty to use the zone root.
- `vpc_cidr` – CIDR block for the created VPC.
- `subnet_cidrs` – list of CIDR blocks for the public subnets.
- `tags` – map of tags applied to all created resources.

Set these variables in the environment's `terraform.tfvars` file to customize the deployment.
