resource "google_compute_network" "main" {
  name                    = var.project_prefix
  auto_create_subnetworks = false
}