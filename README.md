# Environment Overview

This repository contains small experiments for local development and for provisioning resources with Terraform.

## Repository Structure

- **cloud_gratis/** - Docker Compose example that runs WordPress and MySQL.
- **iac-gke/** - Terraform configuration that creates a sample Google Kubernetes Engine (GKE) cluster. This directory also includes an optional script `install-kubecolor.sh` for colored `kubectl` output.

## Terraform Version Requirements

The `iac-gke` configuration specifies `>= 0.13` in the `terraform` block in `main.tf`.

## Using tfvars

Create a `terraform.tfvars` file inside `iac-gke` to set values for variables such as `project_id`, `region`, `cluster_name`, `node_count` and scaling limits.

Example `terraform.tfvars`:

```hcl
project_id   = "my-gcp-project"
region       = "us-central1"
cluster_name = "my-gke-cluster"
node_count   = 2
min_node_count = 1
max_node_count = 4
```

## Deploying `iac-gke`

```bash
cd iac-gke
terraform init
terraform plan
terraform apply
```

## Deploying the Docker Environment

```bash
cd cloud_gratis
docker compose up -d
```
