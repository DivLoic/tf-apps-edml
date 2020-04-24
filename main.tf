provider "google-beta" {
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
  provider           = google-beta
  name               = "edml-apps-kube"
  location           = "europe-west2-b"
  network            = google_compute_network.apps_kube_network.name
  subnetwork         = google_compute_subnetwork.apps_kube_subnet.name
  initial_node_count = var.kube_nodes
  release_channel {
    channel = "RAPID"
  }
}