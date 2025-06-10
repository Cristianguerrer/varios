variable "project_id" {
  description = "The ID of the GCP project"
  type        = string
}

variable "region" {
  description = "The region to deploy resources in"
  type        = string
}

variable "zones" {
  description = "The zones to deploy the cluster in"
  type        = list(string)
}

variable "cluster_name" {
  description = "The name of the Kubernetes cluster"
  type        = string
}

variable "node_count" {
  description = "The number of nodes for the default node pool"
  type        = number
}

variable "min_node_count" {
  description = "Minimum number of nodes in the node pool"
  type        = number
}

variable "max_node_count" {
  description = "Maximum number of nodes in the node pool"
  type        = number
}

variable "master_version" {
  description = "Version cluster gke"
  type        = string
}
