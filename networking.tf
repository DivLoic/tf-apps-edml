resource "google_compute_network" "apps_kube_network" {
  name                    = "${var.project_prefix}-network"
  project                 = var.gcp_project
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "apps_kube_subnet" {
  network       = google_compute_network.apps_kube_network.name
  name          = "${var.project_prefix}-subnet"
  project       = var.gcp_project
  region        = var.gcp_region
  ip_cidr_range = "10.0.3.0/28"
}

resource "google_compute_firewall" "https-lb-access" {
  name    = "kube-https-firewall"
  project = var.gcp_project
  network = google_compute_network.apps_kube_network.name
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  source_ranges = concat(
    data.google_compute_lb_ip_ranges.ranges.http_ssl_tcp_internal
  )
  target_tags = [
    "gke-edml-apps"
  ]
}