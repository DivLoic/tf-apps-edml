provider "google" {
  version      = "2.20"
  project      = var.gcp_project
  region       = var.gcp_region
  access_token = data.google_service_account_access_token.default.access_token
}

terraform {
  backend "gcs" {
    bucket = "edml"
    prefix = "/metadata/clients"
  }
}

resource "google_container_cluster" "apps-kube" {
  name               = "edml-apps-kube"
  location           = "europe-west2-b"
  initial_node_count = 5
}

module "ksql" {
  source                        = "./modules/ksql"
  project_prefix                = var.project_prefix
  gcp_project                   = var.gcp_project
  gcp_region                    = var.gcp_region
  gcp_network                   = google_compute_network.main.id
  gcp_availability_zones        = data.google_compute_zones.available.names
  confluent_cloud_configuration = var.confluent_cloud_configuration
}
