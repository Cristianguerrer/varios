module "gke" {
  source = "../../modules/gke"

  project_id     = var.project_id
  region         = var.region
  zones          = var.zones
  cluster_name   = var.cluster_name
  node_count     = var.node_count
  min_node_count = var.min_node_count
  max_node_count = var.max_node_count
  master_version = var.master_version
}
