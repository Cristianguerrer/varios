# Environment Overview

This repository contains small experiments for local development and for provisioning resources with Terraform.

## Repository Structure

- **cloud_gratis/** - Docker Compose example that runs WordPress and MySQL.
- **iac-gke/** - Contains all infrastructure code. Inside you'll find a reusable module under `modules/gke` and per-environment configurations in `envs/`.
- **n8n-aws-docker-k8s/** - Terraform for launching an AWS EC2 instance running n8n with Docker.

## Terraform Version Requirements

The `iac-gke` configuration specifies `>= 0.13` in the `terraform` block in `main.tf`.

## Using tfvars

Create a `terraform.tfvars` file inside each environment directory (for example `iac-gke/envs/dev` or `iac-gke/envs/prod`) to set values for variables such as `project_id`, `region`, `cluster_name`, `node_count` and scaling limits.

Example `terraform.tfvars`:

```hcl
project_id   = "my-gcp-project"
region       = "us-central1"
cluster_name = "my-gke-cluster"
node_count   = 2
min_node_count = 1
max_node_count = 4
```

Additional optional variables allow customizing the network and node settings per environment:

```hcl
network_name          = "my-vpc"
subnetwork_name       = "my-subnet"
ip_cidr_range         = "10.0.0.0/16"
cluster_machine_type  = "e2-medium"
cluster_disk_size_gb  = 50
node_pool_machine_type = "e2-medium"
node_pool_disk_size_gb = 50
```

These variables make it possible to fully isolate environments by choosing different machine types, disk sizes and network ranges.

## Deploying `iac-gke`

```bash
cd iac-gke/envs/<environment>
terraform init
terraform plan
terraform apply
```

## Deploying the Docker Environment

```bash
cd cloud_gratis
docker compose up -d
```

## Deploying n8n on AWS

```bash
cd n8n-aws-docker-k8s/envs/dev
terraform init
terraform apply
```

The EC2 module now provisions a VPC with one or more public subnets, an internet gateway and
a route table. Use the following variables to control the network ranges:

```hcl
vpc_cidr     = "10.0.0.0/16"
subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
```

After apply, Terraform outputs the VPC ID, the list of subnet IDs and the instance's public
IP address.

