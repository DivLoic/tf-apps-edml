variable "gcp_project" {}

variable "gcp_region" {
  default = "europe-west2"
}

variable "project_prefix" {
  default = "edml-apps"
}

variable "kube_nodes" {
  type    = number
  default = 5
}

variable "kube_version" {
  type    = string
  default = "1.14.10-gke.27"
}

variable "service_account_id" {}